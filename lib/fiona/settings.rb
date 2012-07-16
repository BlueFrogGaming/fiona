module Fiona

  class Settings
    def initialize(&block)
      @state = :initializing
      @defaults = {}

      yield(self)

      merge_settings
      @state = :initialized
    end

    def default(key, value, scope = nil)
      raise 'You must set defaults when initializing' unless @state == :initializing
      raise 'You must provide a key' if key.nil?
      raise 'Key must be a symbol' unless key.is_a?(Symbol)
      raise 'You must provide a scope' if scope.nil? && @defaults[key]
      raise 'You can not change a scope' if @defaults[key] && scope
      raise 'Scope must be :public or :private' if scope && ![:public, :private].include?(scope)

      setting = @defaults[key] ||= {}
      setting[:value] = value
      setting[:scope] = scope if scope

      return true
    end

    def all_settings
      return @merged.clone
    end

    def public_settings
      return settings_for_scope(:public)
    end

    def private_settings
      return settings_for_scope(:private)
    end

    def settings_for_scope(scope)
      return @merged.select { |k, v| v[:scope] == scope }
    end

    def reload
      return merge_settings
    end

    def method_missing(m, *args, &block)
      m = m.to_sym

      if @merged.include?(m)
        return @merged[m][:value]
      else
        raise 'Unknown key'
      end
    end

    private

    def merge_settings
      @merged = {}

      @defaults.each do |k, v|
        @merged[k] = { :value => v[:value], :scope => v[:scope] }

        if (template = Fiona::SettingTemplate.find_by_key("setting_#{k}"))
          @merged[k][:value] = template.value
        end
      end

      return all_settings
    end
  end

end
