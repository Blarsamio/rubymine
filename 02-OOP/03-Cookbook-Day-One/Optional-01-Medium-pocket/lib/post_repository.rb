require 'csv'
require 'open-uri'
require 'nokogiri'
require_relative 'post'

class PostRepository
  def initialize
    @posts = []
    load_csv
  end

  def all
    @posts
  end

  def add(path)
    scrape(path)
    update_csv
  end

  def mark_read(index)
    @posts[index].read = true
    update_csv
  end

  private

  def load_csv
    CSV.foreach('lib/posts.csv', encoding: 'ISO-8859-1') do |row|
      @posts << Post.new(path: row[0], title: row[1], body: row[2], author: row[3], read: row[4] == 'true')
    end
  end

  def update_csv
    CSV.open('lib/posts.csv', 'wb') do |csv|
      @posts.each { |post| csv << [post.path, post.title, post.body, post.author, post.read?] }
    end
  end

  def scrape(path)
    url = "https://dev.to/#{path}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    doc.search('.article-wrapper').each do |element|
      title = element.search('.crayons-article__header__meta').search('h1').text.strip
      author_raw = element.search('.crayons-article__subheader').text.strip
      author = author_raw.scan(/\A\w+\s\w+/).first
      body = doc.at_css('div#article-body').text.strip
      @posts << Post.new(path: path, title: title, author: author, body: body, read: false)
    end
  end
end
