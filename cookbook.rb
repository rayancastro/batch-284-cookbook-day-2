require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file)
    @recipes = [] # <--- <Recipe> instances
    @csv_file = csv_file
    load_csv
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_to_csv
  end

  def mark_as_done(index)
    # Get the recipe at the desired index
    recipe = @recipes[index]
    # Set recipe as done
    recipe.mark_as_done!
    # Save CSV
    save_to_csv
  end

  def all
    return @recipes
  end

  private

  def load_csv
    csv_options = {
      headers: :first_row,
      header_converters: :symbol
    }

    CSV.foreach(@csv_file, csv_options) do |row|
      row[:done] = (row[:done] == "true")

      @recipes << Recipe.new(row)
    end
  end

  def save_to_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ["name", "description", "prep_time", "done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done?]
      end
    end
  end
end
