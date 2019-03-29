# An object that acts sort of similar to an ActiveResource object
# but without all the extras ActiveResource gives that doesn't exist for this.
class NoSvcObject
  BASE_DATETIME_KEYS = %w[
    updated_at
    created_at
  ].freeze

  def initialize(payload)
    BASE_DATETIME_KEYS.each do |key|
      payload[key] = to_datetime(payload[key])
    end

    payload.each do |key, value|
      define_instance_variable(key, value)
      define_getter(key)
      define_setter(key, value)
    end
  end

  def to_hash
    hash = {}
    instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

  private

  def define_instance_variable(key, value)
    instance_variable_set("@#{key}", value)
  end

  def define_getter(key)
    define_singleton_method(key) do
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
    datetime_string.present? ? Time.parse(datetime_string) : datetime_string
  end
end
