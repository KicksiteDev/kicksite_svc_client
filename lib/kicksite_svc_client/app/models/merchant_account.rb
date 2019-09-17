# Represents a School's MerchantAccount
class MerchantAccount < NoSvcObject
  USA_EPAY_TYPE = 'UsaEpayMA'.freeze
  BASYS_TYPE = 'BasysMA'.freeze

  def save
    begin
      save!
    rescue StandardError
      return false
    end

    true
  end

  def save!
    KicksiteSvcBasicAuth.put("#{business_entity_type.downcase.pluralize}/#{business_entity_id}/merchant_account",
                             to_hash)
  end
end
