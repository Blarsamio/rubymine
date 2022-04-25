require_relative 'recipe'
require_relative 'view'
require_relative 'scraper'
require 'pry'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @scraper = Scraper.new
  end

  def list
    @view.display(@cookbook.all)
  end

  def create
    name = @view.ask('Recipe Name?')
    # 1. Get description from view
    description = @view.ask('Recipe Description')
    # 2. Create new task
    ratings = @view.ask('What would you rate it?')
    prep_time = @view.ask('What is the prep time?')
    recipe = Recipe.new({name: name, description: description, ratings: ratings, prep_time: prep_time})
    # 3. Add to repo
    @cookbook.add_recipe(recipe)
    list
  end

  def destroy
    # 1. Display list with indices
    @view.display(list)
    # 2. Ask user for index
    index = @view.ask('What is the recipe index?').to_i - 1
    # 3. Remove from repository
    @cookbook.remove_recipe(index)
    list
  end

  def import
    ingredient = @view.ask("What ingredient would you like?")
    puts "Looking online for some recipes, please be patient since I'm a slow machine..."
    results = @scraper.search(ingredient)
    @view.display(results)
    index = @view.ask('What is the recipe index?').to_i - 1
    recipe = results[index.to_i]
    @cookbook.add_recipe(recipe)
    end

  def mark_as_done
    list
    index = @view.ask('Which index would you like to mark as done?')
    @cookbook.mark_as_done(index.to_i)
    list
  end
end