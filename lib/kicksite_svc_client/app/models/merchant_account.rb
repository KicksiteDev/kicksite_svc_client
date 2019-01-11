# Represents a School's MerchantAccount
class MerchantAccount
  USA_EPAY_TYPE = 'UsaEpayMA'.freeze

  def initialize(payload)
    payload.each do |key, value|
      define_instance_variable(key, value)
      define_getter(key)
      define_setter(key, value)
    end
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
end
