require_relative 'view'

class Controller
  def initialize(repository)
    @repository = repository
    @view = View.new
  end

  def list
    if @repository.all.length.zero?
      @view.no_posts
    else
      @view.display_list(@repository.all)
    end
  end

  def save
    path = @view.save
    @repository.add(path)
  end

  def read
    if @repository.all.length.zero?
      @view.no_posts
    else
      @view.display_list(@repository.all)
      index = @view.ask_for_index
      @view.display_post(@repository.all[index])
    end
  end

  def mark_read
    if @repository.all.length.zero?
      @view.no_posts
    else
      @view.display_list(@repository.all)
      index = @view.ask_for_index
      @repository.mark_read(index)
    end
  end
end
