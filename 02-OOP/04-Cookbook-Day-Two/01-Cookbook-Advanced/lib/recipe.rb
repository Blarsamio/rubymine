class Recipe
  attr_reader :name, :description, :done, :prep_time, :ratings

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @done = attributes[:done] || false
    @prep_time = attributes[:prep_time]
    @ratings = attributes[:ratings]
  end

  def done!
    @done = true
  end
end
