require 'kaminari'

class PaginatedCollection < ActiveResource::Collection

  # Our custom array to handle pagination methods
  attr_accessor :paginatable_array

  # The initialize method will receive the ActiveResource parsed result
  # and set @elements.
  def initialize(elements = [])
    @elements = elements
    setup_paginatable_array
  end

  # Retrieve response headers and instantiate a paginatable array
  def setup_paginatable_array
    @paginatable_array ||= begin
      headers = KicksiteSvcBase.connection.http_response.headers rescue {}
      page = headers[:page].try(:first).try(:to_i)
      per_page = headers[:per_page].try(:first).try(:to_i)
      total_count = headers[:total].try(:first).try(:to_i)

      options = {
        offset: (page.present? && per_page.present?) ? ((page - 1) * per_page) : nil,
        limit: per_page,
        total_count: total_count
      }

      Kaminari::PaginatableArray.new(elements, options)
    end
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
end
