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
    rescue
      return false
    end

    true
  end

  def save!
    raise 'Invalid Url' if @url.nil?
    KicksiteSvcBearerAuth.put(@url, nil, @items.map{ |item| item.to_hash }.to_json)
  end
end
