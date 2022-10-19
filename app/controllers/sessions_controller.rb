require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # the view should ask user for username
    username = @sessions_view.ask_for('username')
    # the view should ask user for password
    password = @sessions_view.ask_for('password')
    # we need to find an instance of an employee from the repo w/the username
    employee = @employee_repository.find_by_username(username) # instance
    # check to see if the password matches the username
    if employee && employee.password == password
      @sessions_view.welcome(employee)
      employee
    else
      @sessions_view.wrong_credentials
      login
    end
  end
end
