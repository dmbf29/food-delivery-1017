require_relative '../views/orders_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def list_undelivered_orders
    # we need to get orders from the repository
    orders = @order_repository.undelivered_orders
    # give the orders to the view to display
    @orders_view.display(orders)
  end

  def add
    # get an instnace of a meal??
    # display the meals
    # index = ask to choose a number/index
    # get that meal from the meals array w/index
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @meals_view.ask_for('number').to_i - 1
    meal = meals[index]

    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @customers_view.ask_for('number').to_i - 1
    customer = customers[index]

    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    index = @employees_view.ask_for('number').to_i - 1
    employee = employees[index]

    # create an instance of an order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    # put that instance into the repository
    @order_repository.create(order)
  end

  def list_my_orders(employee)
    # orders = all undelivered that belong to me
    orders = @order_repository.my_undelivered_orders(employee)
    # display the orders
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    # get my undelivered orders
    orders = @order_repository.my_undelivered_orders(employee)
    # list them
    @orders_view.display(orders)
    # ask user for number/index
    index = @orders_view.ask_for('number').to_i - 1
    # get the order with the index
    order = orders[index]
    # give the order to the order repository to mark and save
    @order_repository.mark_as_delivered(order)
  end
end
