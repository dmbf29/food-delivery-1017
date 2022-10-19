require 'csv'

class MealRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  def find(id) # return an instance
    @meals.find do |meal|
      meal.id == id
    end
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << Meal.headers
      @meals.each do |meal|
        csv << meal.build_row
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      attributes[:id] = attributes[:id].to_i
      attributes[:price] = attributes[:price].to_i
      # we've now updated the attributes to be the data type that we need
      meal = Meal.new(attributes)
      @meals << meal
      @next_id = meal.id + 1
    end
  end
end
