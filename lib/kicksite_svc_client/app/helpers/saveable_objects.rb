# For those special sorts of collections that can be posted back to the backend all together to update.
class SaveableObjects
  include Enumerable

  attr_reader :items
  attr_reader :url

  def initialize(items = [], url = nil)
    @items = items
    @url = url
  end

  def each(&block)
    @items.each(&block)
  end

  def save
    raise 'Invalid Url' if @url.nil?

    begin
      save!
    rescue StandardError
      return false
    end

    true
  end

  def save!
    raise 'Invalid Url' if @url.nil?

    KicksiteSvcBearerAuth.put(@url, nil, @items.map(&:to_hash).to_json)
  end
end
