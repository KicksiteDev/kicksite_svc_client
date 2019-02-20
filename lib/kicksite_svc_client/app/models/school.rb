require_relative '../helpers/kicksite_svc_basic_auth'
require_relative '../helpers/no_svc_object'

# REST resources specific to Schools
class School < KicksiteSvcBasicAuth
  class Logo < NoSvcObject; end
  class Statistic < NoSvcObject; end

  GROWTH_STATISTIC_TYPE = 'growth'.freeze
  STUDENTS_STATISTIC_GROUP = 'students'.freeze

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

  # Students at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of students associated with school
  def students(options = {})
    Schools::Student.find(:all, options.deep_merge({ params: { school_id: self.id } }))
  end

  def statistic(group, type)
    payload = KicksiteSvcBearerAuth.get("schools/#{self.id}/stats/#{type}/#{group}")
    School::Statistic.new(payload) if payload.present?
  end
end
