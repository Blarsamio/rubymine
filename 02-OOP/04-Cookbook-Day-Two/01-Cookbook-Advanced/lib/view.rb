class View
  def ask(question)
    puts "#{question}"
    gets.chomp
  end

  def display(element)
    element.each_with_index do |recipe, index|
      status = recipe.done ? "[X]" : "[ ]"
      puts "#{index + 1}. #{recipe.name} - #{recipe.description} \n"
      puts " -- Preparation Time: #{recipe.prep_time} min. | Rating: #{recipe.ratings} | Done: #{status}"
    end
  end
end