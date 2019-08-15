require_relative '../helpers/kicksite_svc_basic_auth'
require_relative '../helpers/no_svc_object'
require_relative '../helpers/paginated_collection'

# REST resources specific to Schools
class School < KicksiteSvcBasicAuth
  class Logo < NoSvcObject; end
  class Statistic < NoSvcObject; end
  class AccountDetails < NoSvcObject; end
  class Configuration < NoSvcObject; end

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

  # School's logo details.
  #
  # @return [School::Logo] Logo details, including url, if present - nil otherwise
  def logo
    payload = get(:logo)
    School::Logo.new(payload) if payload.present?
  end

  # School's merchant account for billing related tasks
  #
  # @return [MerchantAccount] Merchant account details if present - nil otherwise
  def merchant_account
    payload = get(:merchant_account)
    MerchantAccount.new(payload) if payload.present?
  end

  # Update/Add merchant account to school.
  # Note: This occurs immediately, does not require a save on the parent school instance.
  def merchant_account=(merchant_account)
    put(
      :merchant_account,
      merchant_account.to_hash
    )
  end

  # Activity history of the system that relates to this school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of activity records associated with school
  def activity(options = {})
    payload = KicksiteSvcBearerAuth.get("schools/#{id}/activity", options)
    PaginatedCollection.new(payload.map { |event| Schools::Activity.new(event) })
  end

  # Students at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of students associated with school
  def students(options = {})
    Schools::Student.find(:all, options.deep_merge(params: { school_id: id }))
  end

  # Custom statistics.
  #
  # @param group [String] Group to calculate statistic about
  # @param type [String] Type of statistic to request
  # @param options [Hash] Options such as custom params
  # @return [School::Statistic] Aggregated data
  def statistic(group, type, options = {})
    payload = KicksiteSvcBearerAuth.get("schools/#{id}/stats/#{type}/#{group}", options)
    School::Statistic.new(payload) if payload.present?
  end

  # Prospects at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of prospects associated with school
  # OR
  # @return CSV string of prospects associated with school (used with exporting of Prospect data)
  def prospects(options = {})
    if options[:params].present? && options[:params][:format].present? && options[:params][:format].casecmp?('csv')
      Csv9000.get("schools/#{id}/prospects", options[:params])
    else
      Schools::Prospect.find(:all, options.deep_merge(params: { school_id: id }))
    end
  end

  # People at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of people associated with school
  def people(options = {})
    Schools::Person.find(:all, options.deep_merge(params: { school_id: id }))
  end

  def search(query, options = {})
    opt = options.dup
    opt = opt.deep_merge(query: query)

    payload = KicksiteSvcBearerAuth.get("schools/#{id}/search", opt)
    PaginatedCollection.new(payload.map { |search_result| Schools::SearchResult.new(search_result) })
  end

  def invoices(options = {})
    Schools::Invoice.find(:all, options.deep_merge(params: { school_id: id }))
  end

  def recurring_billings(options = {})
    Schools::RecurringBilling.find(:all, options.deep_merge(params: { school_id: id }))
  end

  def association_memberships(options = {})
    Schools::AssociationMembership.find(:all, options.deep_merge(params: { school_id: id }))
  end

  # Memberships at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of memberships associated with school
  def memberships(options = {})
    Schools::Membership.find(:all, options.deep_merge(params: { school_id: id }))
  end

  # Details such as delinquency of the school, etc.
  #
  # @param options [Hash] Options such as custom params
  # @return [School::AccountDetails] Account details for school
  def account_details(options = {})
    payload = get(:account_details, options)
    School::AccountDetails.new(payload) if payload.present?
  end

  # Any type of configuration at the school level.
  #
  # @param key [Symbol] Type of configuration desired
  # @param options [Hash] Options such as custom params
  # @return [Array/School::Configuration] Configuration(s) based on type requested
  def configuration(key, options = {})
    payload = KicksiteSvcBearerAuth.get("schools/#{id}/configuration/#{key}", options)
    return nil unless payload.present?

    if payload.is_a?(Array)
      items = payload.map { |configuration| School::Configuration.new(configuration) }
      return SaveableObjects.new(items, "schools/#{id}/configuration/#{key}")
    end

    School::Configuration.new(payload)
  end
end
