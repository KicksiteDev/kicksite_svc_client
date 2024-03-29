module Kicksite
  # An object that acts sort of similar to an ActiveResource object
  # but without all the extras ActiveResource gives that doesn't exist for this.
  class NoSvcObject
    BASE_DATETIME_KEYS = %w[
      updated_at
      created_at
    ].freeze

    def initialize(payload = {}, persisted = false)
      if persisted
        BASE_DATETIME_KEYS.each do |key|
          payload[key] = to_datetime(payload[key]) if payload[key].present?
        end
      end

      payload.each do |key, value|
        recursive_define(key, value)
      end
    end

    def to_hash
      hash = {}
      instance_variables.each do |var|
        get_var = instance_variable_get(var)
        hash[var.to_s.delete('@')] = if get_var.present? && get_var.respond_to?(:to_hash)
                                       get_var.to_hash
                                     elsif get_var.present? && get_var.respond_to?(:attributes)
                                       get_var.attributes
                                     else
                                       get_var
                                     end
      end

      hash
    end

    def respond_to_missing?(method_name, include_private = false)
      (method_name.to_s.end_with?('=') && args.count == 1) || super
    end

    private

    # Allows setting of new methods onto the object. Thanks ActiveResource.
    def method_missing(method, *args, **_, &block)
      if method.to_s.end_with?('=') && args.count == 1
        key = method.to_s.sub('=', '')
        value = args.first

        recursive_define(key, value)
      else
        super
      end
    end

    def recursive_define(key, value)
      case value
      when Hash
        define_instance_variable(key, Kicksite::NoSvcObject.new(value))
        define_setter(key, Kicksite::NoSvcObject.new(value))
      when Array
        define_instance_variable(key,
                                 value.map { |item| item.is_a?(Hash) ? Kicksite::NoSvcObject.new(item) : item })
        define_setter(key, value.map { |item| item.is_a?(Hash) ? Kicksite::NoSvcObject.new(item) : item })
      else
        define_instance_variable(key, value)
        define_setter(key, value)
      end

      define_getter(key, value)
    end

    def define_instance_variable(key, value)
      instance_variable_set("@#{key}", value)
    end

    def define_getter(key, value)
      define_singleton_method(key) do
        instance_variable_get("@#{key}")
      end
      return unless !value.nil? && [true, false].include?(value)

      define_singleton_method("#{key}?") do
        instance_variable_get("@#{key}")
      end
    end

    def define_setter(key, _value)
      define_singleton_method("#{key}=") do |value|
        instance_variable_set("@#{key}", value)
      end
    end

    protected

    def to_datetime(datetime_string)
      return datetime_string unless datetime_string.present?
      return datetime_string unless datetime_string.is_a?(String)

      Time.parse(datetime_string)
    end
  end
end
