class Template < ActiveRecord::Base
  has_many :raw_attributes, :class_name => 'TemplateAttribute', :dependent => :destroy

  after_save :save_attributes
  after_initialize :rebuild_processed_attributes

  def self.serialize_attribute(value)
    return ActiveSupport::JSON.encode({:json => value})
  end

  def self.deserialize_attribute(value)
    return ActiveSupport::JSON.decode(value)['json']
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /=$/
      method = method.to_s.gsub(/=$/, '').to_sym
      processed_attributes[method] = args[0]
      return args[1]
    else
      method = method.to_sym
      if processed_attributes.keys.include?(method)
        return processed_attributes[method]
      end
    end

    super
  end

  def save_attributes
    return unless @processed_attributes
    raise 'You must first save the template.' unless id

    @processed_attributes.each do |key, val|
      TemplateAttribute.transaction do
        raw_attr = TemplateAttribute.find_or_initialize_by_template_id_and_key(id, key)
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
end
