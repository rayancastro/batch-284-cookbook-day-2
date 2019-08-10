require_relative "view"
require_relative "recipe"
require_relative "scrape_marmiton_service"
require_relative "scrape_french_service"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  # USER ACTIONS

  def list
    display_recipes
  end

  def create
    # 1. Ask user for a name (view)
    name = @view.ask_user_for("name")
    # 2. Ask user for a description (view)
    description = @view.ask_user_for("description")
    # 3. Create recipe (model)
    recipe = Recipe.new(name: name, description: description)
    # 4. Store in cookbook (repo)
    @cookbook.add_recipe(recipe)
    # 5. Display
    display_recipes
  end

  def import
    # Ask user for a keyword
    keyword = @view.ask_user_for("keyword")
    # Call scraping service to get the list of recipes
    # ask french or marmiton
    service = @view.ask_user_which_service
    if service == 1
    choosen_service = ScrapeFrenchService.new(keyword)
    else
    choosen_service = ScrapeMarmitonService.new(keyword)
    end
    results = choosen_service.call
    # Ask the user which recipe he wants to save
    @view.display(results)
    index = @view.ask_user_for_index
    # Save the recipe in the repository
    recipe = results[index]
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    # List all recipes
    display_recipes
    # Ask user which recipe he wants do mark as done
    index = @view.ask_user_for_index
    # Set the recipe as done, and update repo
    @cookbook.mark_as_done(index)
  end

  def destroy
    # 1. Display recipes
    display_recipes
    # 2. Ask user for index (view)
    index = @view.ask_user_for_index
    # 3. Remove from cookbook (repo)
    @cookbook.remove_recipe(index)
    # 4. Display
    display_recipes
  end

  private

  def display_recipes
    # 1. Get recipes (repo)
    recipes = @cookbook.all
    # 2. Display recipes in the terminal (view)
    @view.display(recipes)
  end
end
