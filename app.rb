require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'
require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/customers_controller'
require_relative 'app/repositories/employee_repository'
require_relative 'app/controllers/sessions_controller'
require_relative 'router'

csv_file_path = 'data/meals.csv'
meal_repository = MealRepository.new(csv_file_path)
meals_controller = MealsController.new(meal_repository)

csv_file_path = 'data/customers.csv'
customer_repository = CustomerRepository.new(csv_file_path)
customers_controller = CustomersController.new(customer_repository)

csv_file_path = 'data/employees.csv'
employee_repository = EmployeeRepository.new(csv_file_path)
sessions_controller = SessionsController.new(employee_repository)


router = Router.new(meals_controller, customers_controller, sessions_controller)
router.run
