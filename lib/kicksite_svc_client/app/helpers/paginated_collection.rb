require 'kaminari'

# Implementation of an ActiveResource collection that takes paging at the service into account.
class PaginatedCollection < ActiveResource::Collection
  # The initialize method will receive the ActiveResource parsed result
  # and set @elements.
  def initialize(elements = [])
    @elements = elements
    paginatable_array
  end

  # Retrieve response headers and instantiate a paginatable array
  def paginatable_array
    @paginatable_array ||= begin
      begin
        headers = KicksiteSvcBase.connection.http_response.headers
      rescue StandardError
        headers = {}
      end

      Kaminari::PaginatableArray.new(elements, options_from_headers(headers))
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    paginatable_array.respond_to?(method_name, include_private) || super
  end

  private

  # Delegate missing methods to our `paginatable_array` first,
  # Kaminari might know how to respond to them
  # E.g. current_page, total_count, etc.
  def method_missing(method, *args, &block)
    if paginatable_array.respond_to?(method)
      paginatable_array.send(method)
    else
      super
    end
  end

  # Convert service response headers to Kaminari expected options.
  #
  # @param headers [Hash] Service response headers
  # @return [Hash] Options Kaminari knows how to deal with
  def options_from_headers(headers)
    page = headers[:page].try(:first).try(:to_i)
    per_page = headers[:per_page].try(:first).try(:to_i)
    total_count = headers[:total].try(:first).try(:to_i)

    {
      offset: page.present? && per_page.present? ? ((page - 1) * per_page) : nil,
      limit: per_page,
      total_count: total_count
    }
  end
end
