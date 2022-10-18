require_relative '../views/meals_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # get all meals from meal repository
    meals = @meal_repository.all
    # give meals the view to display
    @meals_view.display(meals)
  end

  def add
    # view should ask user for meal name
    name = @meals_view.ask_for('name')
    # view should ask user for meal price
    price = @meals_view.ask_for('price').to_i
    # create a new instance of a meal
    meal = Meal.new(
      name: name,
      price: price
    )
    # give it to the meal repository
    @meal_repository.create(meal)
  end
end
