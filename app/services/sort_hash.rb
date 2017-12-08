class SortHash < Hash

  def initialize(sort_hash)
    @key = sort_hash[:key]
    @value = sort_hash[:value]
  end

  def key
    @key
  end
  
  def value
    @value
  end
end
