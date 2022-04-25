class Post
  attr_reader :path, :author, :title, :body
  attr_accessor :read

  def initialize(attributes = {})
    @url = attributes[:path]
    @title = attributes[:title]
    @author = attributes[:author]
    @body = attributes[:body]
    @read = attributes[:read]
  end

  def read?
    @read
  end
end
