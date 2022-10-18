class Meal
  attr_accessor :id, :name, :price

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @name = attributes[:name] # string
    @price = attributes[:price] # integer
  end

  def self.headers
    ['id', 'name', 'price']
  end

  def build_row
    [@id, @name, @price]
  end
end
