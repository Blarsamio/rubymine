class View
  def display_list(posts)
    puts ''
    posts.each_with_index do |post, index|
      if post.read == false
        x = ' '
      else
        x = 'x'
      end
      puts "#{index + 1}. [#{x}] #{post.title} (#{post.author})"
    end
  end

  def display_post(post)
    puts ''
    puts post.title
    puts ''
    puts "by #{post.author}"
    puts ''
    post.body.each_line("\n", chomp: true) { |str| puts str }
  end

  def ask_for_index
    puts 'Index?'
    gets.chomp.to_i - 1
  end

  def save
    puts ''
    puts 'Path?'
    gets.chomp
  end

  def no_posts
    puts ''
    puts 'No posts to show.'
  end
end
