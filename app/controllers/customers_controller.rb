require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # get all customers from customer repository
    customers = @customer_repository.all
    # give customers the view to display
    @customers_view.display(customers)
  end

  def add
    # view should ask user for customer name
    name = @customers_view.ask_for('name')
    # view should ask user for customer address
    address = @customers_view.ask_for('address')
    # create a new instance of a customer
    customer = Customer.new(
      name: name,
      address: address
    )
    # give it to the customer repository
    @customer_repository.create(customer)
  end
end
