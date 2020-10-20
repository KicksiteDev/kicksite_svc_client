module Kicksite
  # REST resources specific to Schools
  class School < KicksiteSvcBasicAuth # rubocop:disable Metrics/ClassLength
    class Logo < Kicksite::NoSvcObject; end
    class Statistic < Kicksite::NoSvcObject; end
    class AccountDetails < Kicksite::NoSvcObject; end
    class Configuration < Kicksite::NoSvcObject; end
    class Address < Kicksite::NoSvcObject; end
    class PhoneNumber < Kicksite::NoSvcObject; end
    class Tag < Kicksite::NoSvcObject; end

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
    # @return [Kicksite::School::Logo] Logo details, including url, if present - nil otherwise
    def logo
      return attributes['logo'] if attributes.key?('logo')

      logo!
    end

    def logo!
      payload = get(:logo)
      attributes['logo'] = payload.present? ? Kicksite::School::Logo.new(payload, true) : nil

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
    # @return [Kicksite::PaginatedCollection] Collection of activity records associated with school
    def activity(options = {})
      return attributes['activity'] if options == {} && attributes.key?('activity')

      activity!(options)
    end

    def activity!(options = {})
      payload = KicksiteSvcBearerAuth.get("schools/#{id}/activity", options)
      attributes['activity'] =
        Kicksite::PaginatedCollection.new(payload.map { |event| Kicksite::Schools::Activity.new(event, true) })

      attributes['activity']
    end

    # Students at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of students associated with school
    def students(options = {})
      return attributes['students'] if options == {} && attributes.key?('students')

      students!(options)
    end

    # rubocop:disable Metrics/AbcSize
    def students!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      if opt[:params].present? && opt[:params][:format].present? && opt[:params][:format].casecmp?('csv')
        Kicksite::Csv9000.get("schools/#{id}/students", opt[:params])
      else
        opt = opt.deep_merge(params: { school_id: id })
        attributes['students'] = Kicksite::Schools::Student.find(:all, opt)

        attributes['students']
      end
    end
    # rubocop:enable Metrics/AbcSize

    # employees at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of employees associated with school
    def employees(options = {})
      return attributes['employees'] if options == {} && attributes.key?('employees')

      employees!(options)
    end

    def employees!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      opt = opt.deep_merge(params: { school_id: id })
      attributes['employees'] = Kicksite::Schools::Employee.find(:all, opt)

      attributes['employees']
    end

    # Prospects at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of prospects associated with school
    # OR
    # @return CSV string of prospects associated with school (used with exporting of Prospect data)
    def prospects(options = {})
      return attributes['prospects'] if options == {} && attributes.key?('prospects')

      prospects!(options)
    end

    # rubocop:disable Metrics/AbcSize
    def prospects!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      if opt[:params].present? && opt[:params][:format].present? && opt[:params][:format].casecmp?('csv')
        Kicksite::Csv9000.get("schools/#{id}/prospects", opt[:params])
      else
        opt = opt.deep_merge(params: { school_id: id })
        attributes['prospects'] = Kicksite::Schools::Prospect.find(:all, opt)

        attributes['prospects']
      end
    end
    # rubocop:enable Metrics/AbcSize

    # People at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of people associated with school
    def people(options = {})
      return attributes['people'] if options == {} && attributes.key?('people')

      people!(options)
    end

    def people!(options)
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      opt = opt.deep_merge(params: { school_id: id })
      attributes['people'] = Kicksite::Schools::Person.find(:all, opt)

      attributes['people']
    end

    # Invoices at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of invoices associated with school
    def invoices(options = {})
      return attributes['invoices'] if options == {} && attributes.key?('invoices')

      invoices!(options)
    end

    def invoices!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      opt = opt.deep_merge(params: { school_id: id })
      attributes['invoices'] = Kicksite::Schools::Invoice.find(:all, opt)

      attributes['invoices']
    end

    # Recurring billings configured at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of recurring billings associated with school
    def recurring_billings(options = {})
      return attributes['recurring_billings'] if options == {} && attributes.key?('recurring_billings')

      recurring_billings!(options)
    end

    def recurring_billings!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      opt = opt.deep_merge(params: { school_id: id })
      attributes['recurring_billings'] = Kicksite::Schools::RecurringBilling.find(:all, opt)

      attributes['recurring_billings']
    end

    # Memberships at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of memberships associated with school
    def memberships(options = {})
      return attributes['memberships'] if options == {} && attributes.key?('memberships')

      memberships!(options)
    end

    def memberships!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      opt = opt.deep_merge(params: { school_id: id })
      attributes['memberships'] = Kicksite::Schools::Membership.find(:all, opt)

      attributes['memberships']
    end

    # Inventory at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of inventory associated with school
    def inventory(options = {})
      return attributes['inventory_items'] if options == {} && attributes.key?('inventory')

      inventory!(options)
    end

    def inventory!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      opt = opt.deep_merge(params: { school_id: id })
      attributes['inventory'] = Kicksite::Schools::Inventory.find(:all, opt)

      attributes['inventory']
    end

    # Agreement options at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of agreements associated with school
    def agreements(options = {})
      return attributes['agreements'] if options == {} && attributes.key?('agreements')

      agreements!(options)
    end

    def agreements!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      opt = opt.deep_merge(params: { school_id: id })
      attributes['agreements'] = Kicksite::Schools::Agreement.find(:all, opt)

      attributes['agreements']
    end

    # Details such as delinquency of the school, etc.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::School::AccountDetails] Account details for school
    def account_details(options = {})
      return attributes['account_details'] if options == {} && attributes.key?('account_details')

      account_details!(options)
    end

    def account_details!(options = {})
      payload = get(:account_details, options)
      attributes['account_details'] = payload.present? ? Kicksite::School::AccountDetails.new(payload, true) : nil

      attributes['account_details']
    end

    # Custom statistics.
    #
    # @param group [String] Group to calculate statistic about
    # @param type [String] Type of statistic to request
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::School::Statistic] Aggregated data
    def statistic(group, type, options = {})
      payload = KicksiteSvcBearerAuth.get("schools/#{id}/stats/#{type}/#{group}", options)
      Kicksite::School::Statistic.new(payload, true) if payload.present?
    end

    # Universal search scoped to a specific school
    #
    # @param query [String] Text to search for
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] List of results
    def search(query, options = {})
      opt = options.dup
      opt = opt.deep_merge(query: query)

      payload = KicksiteSvcBearerAuth.get("schools/#{id}/search", opt)
      Kicksite::PaginatedCollection.new(
        payload.map { |search_result| Kicksite::Schools::SearchResult.new(search_result, true) }
      )
    end

    # Any type of configuration at the school level.
    #
    # @param key [Symbol] Type of configuration desired
    # @param options [Hash] Options such as custom params
    # @return [Array/Kicksite::School::Configuration] Configuration(s) based on type requested
    def configuration(key, options = {})
      payload = KicksiteSvcBearerAuth.get("schools/#{id}/configuration/#{key}", options)
      return nil unless payload.present?

      if payload.is_a?(Array)
        items = payload.map { |configuration| Kicksite::School::Configuration.new(configuration, true) }
        return Kicksite::SaveableObjects.new(items, "schools/#{id}/configuration/#{key}")
      end

      Kicksite::School::Configuration.new(payload, true)
    end

    def address
      return attributes['address'] if attributes.key?('address')

      address!
    end

    def address!
      payload = KicksiteSvcBearerAuth.get("schools/#{id}/address")
      attributes['address'] = payload.present? ? Kicksite::School::Address.new(payload, true) : nil

      attributes['address']
    end

    # Lead capture forms at this particular school.
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::PaginatedCollection] Collection of lead capture forms owned by school
    # OR
    # @return CSV string of lead capture form descriptions
    def lead_capture_forms(options = {})
      return attributes['lead_capture_forms'] if options == {} && attributes.key?('lead_capture_forms')

      lead_capture_forms!(options)
    end

    # rubocop:disable Metrics/AbcSize
    def lead_capture_forms!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      if opt[:params].present? && opt[:params][:format].present? && opt[:params][:format].casecmp?('csv')
        Kicksite::Csv9000.get("schools/#{id}/bizbuilder/forms", opt[:params])
      else
        opt = opt.deep_merge(params: { school_id: id })
        attributes['lead_capture_forms'] = Kicksite::Schools::Bizbuilder::Form.find(:all, opt)

        attributes['lead_capture_forms']
      end
    end
    # rubocop:enable Metrics/AbcSize

    def message_flows(options = {})
      return attributes['message_flows'] if options == {} && attributes.key?('message_flows')

      message_flows!(options)
    end

    def message_flows!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      opt = opt.deep_merge(params: { school_id: id })
      attributes['message_flows'] = Kicksite::Schools::MessageFlow.find(:all, opt)

      attributes['message_flows']
    end

    def landing_pages(options = {})
      return attributes['landing_pages'] if options == {} && attributes.key?('landing_pages')

      landing_pages!(options)
    end

    # rubocop:disable Metrics/AbcSize
    def landing_pages!(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      if opt[:params].present? && opt[:params][:format].present? && opt[:params][:format].casecmp?('csv')
        Kicksite::Csv9000.get("schools/#{id}/bizbuilder/landing_pages", opt[:params])
      else
        opt = opt.deep_merge(params: { school_id: id })
        attributes['landing_pages'] = Kicksite::Schools::Bizbuilder::LandingPage.find(:all, opt)

        attributes['landing_pages']
      end
    end
    # rubocop:enable Metrics/AbcSize

    # Phone number for school
    #
    # @param options [Hash] Options such as custom params
    # @return [Kicksite::School::PhoneNumber] Phone number for school
    def phone_number(options = {})
      return attributes['phone_number'] if options == {} && attributes.key?('phone_number')

      phone_number!(options)
    end

    def phone_number!(options = {})
      payload = get(:phone_number, options)
      attributes['phone_number'] = payload.present? ? Kicksite::School::PhoneNumber.new(payload, false) : nil

      attributes['phone_number']
    end

    def tags
      return attributes['tags'] if attributes.key?('tags')

      tags!
    end

    def tags!
      payload = KicksiteSvcBearerAuth.get("schools/#{id}/tags")
      attributes['tags'] = payload.map { |tag| Kicksite::School::Tag.new(tag, true) }

      attributes['tags']
    end
  end
end
