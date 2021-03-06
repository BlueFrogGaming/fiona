class Template < ActiveRecord::Base

  has_many :raw_attributes, :class_name => 'TemplateAttribute', :dependent => :destroy

  after_save :save_attributes

  def self.serialize_attribute(value)
    return ActiveSupport::JSON.encode({:json => value})
  end

  def self.deserialize_attribute(value)
    return ActiveSupport::JSON.decode(value)['json']
  end

  def method_missing(method, *args, &block)
    unless @initialized
      rebuild_processed_attributes
      @initialized = true
    end

    if method.to_s =~ /=$/
      raise 'Template is frozen.' if frozen?

      method = method.to_s.gsub(/=$/, '').to_sym
      processed_attributes[method] = args[0]

      return args[1]
    else
      method = method.to_sym

      if processed_attributes.keys.include?(method)
        return processed_attributes[method]
      elsif default_attributes.keys.include?(method)
        return default_attributes[method]
      end
    end

    super
  end

  def save_attributes
    return unless @processed_attributes

    raise 'You must first save the template.' unless id
    raise 'Template is frozen.' if frozen?

    @processed_attributes.each do |key, val|
      TemplateAttribute.transaction do
        raw_attr = raw_attributes.find_or_initialize_by_template_id_and_key(id, key)
        raw_attr.value = Template.serialize_attribute(val)
        raw_attr.save!
      end
    end
  end

  def processed_attributes
    return @processed_attributes if @processed_attributes
    return rebuild_processed_attributes
  end

  def rebuild_processed_attributes
    @processed_attributes = {}

    raw_attributes.each do |ra|
      @processed_attributes[ra.key.to_sym] = Template.deserialize_attribute(ra.value)
    end

    return @processed_attributes
  end

  def default_attributes
    return @default_attributes || {}
  end

  def default_attributes=(defaults)
    @default_attributes = defaults
  end

  def delete_attribute(attribute)
    raise 'Template is frozen.' if frozen?

    if processed_attributes.include?(attribute)
      raw_attributes.where(:key => attribute).map{ |a| a.destroy }
      return processed_attributes.delete(attribute)
    else
      return nil
    end
  end

  def all_attributes
    return default_attributes.dup.merge(processed_attributes)
  end
end
