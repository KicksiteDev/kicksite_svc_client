require_relative '../helpers/kicksite_svc_basic_auth'
require_relative '../helpers/no_svc_object'

# REST resources specific to Schools
class School < KicksiteSvcBasicAuth
  class Logo < NoSvcObject; end

  def logo
    payload = get(:logo)
    School::Logo.new(payload) if payload.present?
  end

  def merchant_account
    payload = get(:merchant_account)
    MerchantAccount.new(payload) if payload.present?
  end

  def merchant_account=(merchant_account)
    put(
      :merchant_account,
      merchant_account.to_hash
    )
  end
end
