class OrdersView < BaseView
  def display(orders)
    if orders.any?
      orders.each_with_index do |order, index|
        print "#{index + 1} - Meal: #{order.meal.name} - ¥#{order.meal.price} - "
        print "Customer: #{order.customer.name} - #{order.customer.address} - "
        puts "Rider: #{order.employee.username}"
      end
    else
      puts "No orders open."
    end
  end
end
