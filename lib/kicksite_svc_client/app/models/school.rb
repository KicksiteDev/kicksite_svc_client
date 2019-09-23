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
    return attributes['logo'] if attributes.key?('logo')

    logo!
  end

  def logo!
    payload = get(:logo)
    attributes['logo'] = payload.present? ? School::Logo.new(payload, true) : nil

    attributes['logo']
  end

  # School's merchant account for billing related tasks
  #
  # @return [MerchantAccount] Merchant account details if present - nil otherwise
  def merchant_account
    return attributes['merchant_account'] if attributes.key?('merchant_account')

    merchant_account!
  end

  def merchant_account!
    payload = get(:merchant_account)
    attributes['merchant_account'] = payload.present? ? MerchantAccount.new(payload, true) : nil

    attributes['merchant_account']
  end

  # Activity history of the system that relates to this school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of activity records associated with school
  def activity(options = {})
    return attributes['activity'] if options == {} && attributes.key?('activity')

    activity!(options)
  end

  def activity!(options = {})
    payload = KicksiteSvcBearerAuth.get("schools/#{id}/activity", options)
    attributes['activity'] = PaginatedCollection.new(payload.map { |event| Schools::Activity.new(event, true) })

    attributes['activity']
  end

  # Students at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of students associated with school
  def students(options = {})
    return attributes['students'] if options == {} && attributes.key?('students')

    students!(options)
  end

  def students!(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    attributes['students'] = Schools::Student.find(:all, opt)

    attributes['students']
  end

  # employees at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of employees associated with school
  def employees(options = {})
    return attributes['employees'] if options == {} && attributes.key?('employees')

    employees!(options)
  end

  def employees!(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    attributes['employees'] = Schools::Employee.find(:all, opt)

    attributes['employees']
  end

  # Prospects at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of prospects associated with school
  # OR
  # @return CSV string of prospects associated with school (used with exporting of Prospect data)
  def prospects(options = {})
    return attributes['prospects'] if options == {} && attributes.key?('prospects')

    prospects!(options)
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/PerceivedComplexity

  def prospects!(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    if opt[:params].present? && opt[:params][:format].present? && opt[:params][:format].casecmp?('csv')
      Csv9000.get("schools/#{id}/prospects", opt[:params])
    else
      opt = opt.deep_merge(params: { school_id: id })
      attributes['prospects'] = Schools::Prospect.find(:all, opt)

      attributes['prospects']
    end
  end

  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/PerceivedComplexity

  # People at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of people associated with school
  def people(options = {})
    return attributes['people'] if options == {} && attributes.key?('people')

    people!(options)
  end

  def people!(options)
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    attributes['people'] = Schools::Person.find(:all, opt)

    attributes['people']
  end

  # Invoices at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of invoices associated with school
  def invoices(options = {})
    return attributes['invoices'] if options == {} && attributes.key?('invoices')

    invoices!(options)
  end

  def invoices!(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    attributes['invoices'] = Schools::Invoice.find(:all, opt)

    attributes['invoices']
  end

  # Recurring billings configured at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of recurring billings associated with school
  def recurring_billings(options = {})
    return attributes['recurring_billings'] if options == {} && attributes.key?('recurring_billings')

    recurring_billings!(options)
  end

  def recurring_billings!(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    attributes['recurring_billings'] = Schools::RecurringBilling.find(:all, opt)

    attributes['recurring_billings']
  end

  # Association memberships at this particular school if they are part of an association.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of association memberships associated with school
  def association_memberships(options = {})
    return attributes['association_memberships'] if options == {} && attributes.key?('association_memberships')

    association_memberships!(options)
  end

  def association_memberships!(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    attributes['association_memberships'] = Schools::AssociationMembership.find(:all, opt)

    attributes['association_memberships']
  end

  # Memberships at this particular school.
  #
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] Collection of memberships associated with school
  def memberships(options = {})
    return attributes['memberships'] if options == {} && attributes.key?('memberships')

    memberships!(options)
  end

  def memberships!(options = {})
    opt = options.dup
    opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
    opt = opt.deep_merge(params: { school_id: id })
    attributes['memberships'] = Schools::Membership.find(:all, opt)

    attributes['memberships']
  end

  # Details such as delinquency of the school, etc.
  #
  # @param options [Hash] Options such as custom params
  # @return [School::AccountDetails] Account details for school
  def account_details(options = {})
    return attributes['account_details'] if options == {} && attributes.key?('account_details')

    account_details!(options)
  end

  def account_details!(options = {})
    payload = get(:account_details, options)
    attributes['account_details'] = payload.present? ? School::AccountDetails.new(payload, true) : nil

    attributes['account_details']
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

  # Universal search scoped to a specific school
  #
  # @param query [String] Text to search for
  # @param options [Hash] Options such as custom params
  # @return [PaginatedCollection] List of results
  def search(query, options = {})
    opt = options.dup
    opt = opt.deep_merge(query: query)

    payload = KicksiteSvcBearerAuth.get("schools/#{id}/search", opt)
    PaginatedCollection.new(payload.map { |search_result| Schools::SearchResult.new(search_result, true) })
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

  def address
    KicksiteSvcBearerAuth.get("schools/#{id}/address")
  end
end
