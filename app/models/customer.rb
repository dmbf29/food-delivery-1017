class Customer
  attr_accessor :id, :name, :address

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @name = attributes[:name] # string
    @address = attributes[:address] # string
  end

  def self.headers
    ['id', 'name', 'address']
  end

  def build_row
    [@id, @name, @address]
  end
end
