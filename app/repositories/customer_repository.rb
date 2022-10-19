require 'csv'

class CustomerRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  def find(id) # return an instance
    @customers.find do |customer|
      customer.id == id
    end
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << Customer.headers
      @customers.each do |customer|
        csv << customer.build_row
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      attributes[:id] = attributes[:id].to_i
      # we've now updated the attributes to be the data type that we need
      customer = Customer.new(attributes)
      @customers << customer
      @next_id = customer.id + 1
    end
  end
end
