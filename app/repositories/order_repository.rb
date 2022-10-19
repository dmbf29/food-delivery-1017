require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    @orders_csv_path = orders_csv_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @next_id = 1
    @orders = []
    load_csv if File.exist?(@orders_csv_path)
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def mark_as_delivered(order)
    # mark the order as delivered
    order.deliver!
    # save
    save_csv
  end

  private

  def save_csv
    CSV.open(@orders_csv_path, 'wb') do |csv|
      csv << Order.headers
      @orders.each do |order|
        csv << order.build_row
      end
    end
  end

  def load_csv
    CSV.foreach(@orders_csv_path, headers: :first_row, header_converters: :symbol) do |attributes|
      attributes[:id] = attributes[:id].to_i
      attributes[:delivered] = attributes[:delivered] == 'true'

      attributes[:meal_id] = attributes[:meal_id].to_i
      meal = @meal_repository.find(attributes[:meal_id])
      attributes[:meal] = meal

      attributes[:customer_id] = attributes[:customer_id].to_i
      customer = @customer_repository.find(attributes[:customer_id])
      attributes[:customer] = customer

      attributes[:employee_id] = attributes[:employee_id].to_i
      employee = @employee_repository.find(attributes[:employee_id])
      attributes[:employee] = employee

      @orders << Order.new(attributes)
      @next_id = @orders.last.id + 1
    end
  end
end
