require_relative '../helpers/kicksite_svc_basic_auth'
require_relative '../helpers/no_svc_object'

# REST resources specific to Schools
class School < KicksiteSvcBasicAuth
  class Logo < NoSvcObject; end
  class Statistic < NoSvcObject; end

  SCHOOL_DATETIME_KEYS = %w[
    subscription_plan_status_date
    subscription_plan_selected_at
    subscription_plan_overage_email_sent_at
  ].freeze

  GROWTH_STATISTIC_TYPE = 'growth'.freeze
  STUDENTS_STATISTIC_GROUP = 'students'.freeze

  def initialize(attributes = {}, persisted = false)
    SCHOOL_DATETIME_KEYS.each do |key|
      attributes[key] = to_datetime(attributes[key])
    end

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
    Schools::Student.find(:all, options.deep_merge(params: { school_id: id }))
  end

  def statistic(group, type, options = {})
    payload = KicksiteSvcBearerAuth.get("schools/#{id}/stats/#{type}/#{group}", options)
    School::Statistic.new(payload) if payload.present?
  end

  def prospects(options = {})
    Schools::Prospect.find(:all, options.deep_merge(params: { school_id: id }))
  end
end
