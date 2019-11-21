# An object that acts sort of similar to an ActiveResource object
# but without all the extras ActiveResource gives that doesn't exist for this.
class NoSvcObject
  BASE_DATETIME_KEYS = %w[
    updated_at
    created_at
  ].freeze

  def initialize(payload = {}, persisted = false)
    @persisted = persisted

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
    instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

  def respond_to_missing?(method_name, include_private = false)
    (method_name.to_s.end_with?('=') && args.count == 1) || super
  end

  private

  # Allows setting of new methods onto the object. Thanks ActiveResource.
  def method_missing(method, *args, &block)
    if method.to_s.end_with?('=') && args.count == 1
      key = method.to_s.sub('=', '')
      value = args.first

      recursive_define(key, value)
    else
      super
    end
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength

  def recursive_define(key, value)
    if value.is_a?(Hash)
      define_instance_variable(key, NoSvcObject.new(value))
      define_setter(key, NoSvcObject.new(value))
    elsif value.is_a?(Array)
      define_instance_variable(key, value.map { |item| item.is_a?(Hash) ? NoSvcObject.new(item) : item })
      define_setter(key, value.map { |item| item.is_a?(Hash) ? NoSvcObject.new(item) : item })
    else
      define_instance_variable(key, value)
      define_setter(key, value)
    end

    define_getter(key, value)
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

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
