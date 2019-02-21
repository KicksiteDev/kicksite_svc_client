require_relative '../helpers/kicksite_svc_basic_auth'
require_relative '../helpers/no_svc_object'

# REST resources specific to Schools
class School < KicksiteSvcBasicAuth
  class Logo < NoSvcObject; end
  class Statistic < NoSvcObject; end

  GROWTH_STATISTIC_TYPE = 'growth'.freeze
  STUDENTS_STATISTIC_GROUP = 'students'.freeze

  def initialize(attributes = {}, persisted = false)
    attributes['subscription_plan_status_date'] = to_datetime(attributes['subscription_plan_status_date']) if attributes['subscription_plan_status_date'].present?
    attributes['subscription_plan_selected_at'] = to_datetime(attributes['subscription_plan_selected_at']) if attributes['subscription_plan_selected_at'].present?
    attributes['subscription_plan_overage_email_sent_at'] = to_datetime(attributes['subscription_plan_overage_email_sent_at']) if attributes['subscription_plan_overage_email_sent_at'].present?

    super(attributes, persisted)
  end

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

  def statistic(group, type, options = {})
    payload = KicksiteSvcBearerAuth.get("schools/#{self.id}/stats/#{type}/#{group}", options)
    School::Statistic.new(payload) if payload.present?
  end
end
