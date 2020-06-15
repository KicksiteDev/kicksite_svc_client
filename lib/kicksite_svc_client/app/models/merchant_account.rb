module Kicksite
  # Represents a School's MerchantAccount
  class MerchantAccount < Kicksite::NoSvcObject
    USA_EPAY_TYPE = 'UsaEpayMA'.freeze
    BASYS_TYPE = 'BasysMA'.freeze
    STRIPE_TYPE = 'StripeMA'.freeze

    def usa_epay?
      type == USA_EPAY_TYPE
    end

    def basys?
      type == BASYS_TYPE
    end

    def stripe?
      type == STRIPE_TYPE
    end

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
end
