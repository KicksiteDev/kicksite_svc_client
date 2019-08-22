require_relative '../helpers/kicksite_svc_basic_auth'
require_relative '../helpers/kicksite_svc_bearer_auth'
require_relative '../helpers/csv_9000'
require_relative '../helpers/no_svc_object'
require_relative '../helpers/paginated_collection'

# REST resources specific to Schools
class School < KicksiteSvcBasicAuth # rubocop:disable Metrics/ClassLength
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
    if persisted
      SCHOOL_DATETIME_KEYS.each do |key|
        attributes[key] = to_datetime(attributes[key])
      end
    end

    super(attributes, persisted)
  end

  # School's logo details.
  #
  # @return [School::Logo] Logo details, including url, if present - nil otherwise
  def logo
    payload = get(:logo)
    School::Logo.new(payload, true) if payload.present?
  end

  # School's merchant account for billing related tasks
  #
  # @return [MerchantAccount] Merchant account details if present - nil otherwise
  def merchant_account
    payload = get(:merchant_account)
    MerchantAccount.new(payload, true) if payload.present?
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
    PaginatedCollection.new(payload.map { |event| Schools::Activity.new(event, true) })
  end

  # Students at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of students associated with school
  def students(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    Schools::Student.find(:all, opt)
  end

  # Custom statistics.
  #
  # @param group [String] Group to calculate statistic about
  # @param type [String] Type of statistic to request
  # @param options [Hash] Options such as custom params
  # @return [School::Statistic] Aggregated data
  def statistic(group, type, options = {})
    payload = KicksiteSvcBearerAuth.get("schools/#{id}/stats/#{type}/#{group}", options)
    School::Statistic.new(payload, true) if payload.present?
  end

  # employees at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of employees associated with school
  def employees(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    Schools::Employee.find(:all, opt)
  end

  # Prospects at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of prospects associated with school
  # OR
  # @return CSV string of prospects associated with school (used with exporting of Prospect data)
  def prospects(options = {}) # rubocop:disable Metrics/AbcSize
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    if opt[:params].present? && opt[:params][:format].present? && opt[:params][:format].casecmp?('csv')
      Csv9000.get("schools/#{id}/prospects", opt[:params])
    else
      opt = opt.deep_merge(params: { school_id: id })
      Schools::Prospect.find(:all, opt)
    end
  end

  # People at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of people associated with school
  def people(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    Schools::Person.find(:all, opt)
  end

  def search(query, options = {})
    opt = options.dup
    opt = opt.deep_merge(query: query)

    payload = KicksiteSvcBearerAuth.get("schools/#{id}/search", opt)
    PaginatedCollection.new(payload.map { |search_result| Schools::SearchResult.new(search_result, true) })
  end

  def invoices(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    Schools::Invoice.find(:all, opt)
  end

  def recurring_billings(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    Schools::RecurringBilling.find(:all, opt)
  end

  def association_memberships(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    Schools::AssociationMembership.find(:all, opt)
  end

  # Memberships at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of memberships associated with school
  def memberships(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    Schools::Membership.find(:all, opt)
  end

  # Details such as delinquency of the school, etc.
  #
  # @param options [Hash] Options such as custom params
  # @return [School::AccountDetails] Account details for school
  def account_details(options = {})
    payload = get(:account_details, options)
    School::AccountDetails.new(payload, true) if payload.present?
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
      items = payload.map { |configuration| School::Configuration.new(configuration, true) }
      return SaveableObjects.new(items, "schools/#{id}/configuration/#{key}")
    end

    School::Configuration.new(payload, true)
  end
end
