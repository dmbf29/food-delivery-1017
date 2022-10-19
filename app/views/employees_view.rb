class EmployeesView < BaseView
  def display(employees) # an array of instances
    if employees.any?
      employees.each_with_index do |employee, index|
        puts "#{index + 1} - #{employee.username} - #{employee.role}"
      end
    else
      puts "No employees yet "
    end
  end
end
