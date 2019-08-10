class View
  def display(recipes)
    puts "Your list of Recipes!"
    recipes.each_with_index do |recipe, index|
      puts "[ #{recipe.done? ? "X" : ""} ] #{index + 1}. #{recipe.name} (#{recipe.prep_time} min) - #{recipe.description}"
    end
  end

  def ask_user_for(stuff)
    puts "#{stuff.upcase}?"
    print "> "
    return gets.chomp
  end

  def ask_user_for_index
    puts "Index?"
    print "> "
    return gets.chomp.to_i - 1
  end
end
