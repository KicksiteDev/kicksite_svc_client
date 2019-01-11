require_relative '../helpers/kicksite_svc_basic_auth'

# REST resources specific to Schools
class School < KicksiteSvcBasicAuth
  def merchant_account
    payload = get(:merchant_account)
    MerchantAccount.new(payload) if payload.present?
  end

  def merchant_account=(merchant_account)
    put(
      :merchant_account,
      type: merchant_account.type,
      pin: merchant_account.pin,
      key: merchant_account.key,
      accept_check: merchant_account.accept_check
    )
  end
end
