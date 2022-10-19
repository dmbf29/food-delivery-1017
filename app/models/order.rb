class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # instance of meal
    @customer = attributes[:customer] # instance
    @employee = attributes[:employee] # instance
    @delivered = attributes[:delivered] || false # boolean
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end

  def build_row
    [@id, @delivered, @meal.id, @customer.id, @employee.id]
  end

  def self.headers
    ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
  end

end
