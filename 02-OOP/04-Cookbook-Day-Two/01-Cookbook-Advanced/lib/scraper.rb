require "open-uri"
require "nokogiri"

class Scraper
  def search(ingredient)
    results = []
    url = "https://www.allrecipes.com/search/results/?search=#{ingredient}"
    doc = Nokogiri::HTML(URI.open(url), nil, 'utf-8')
    doc.search('.card__detailsContainer').first(5).each do |card|
      name = card.search('.card__title').text.strip
      description = card.search('.card__summary').text.strip
      rating_list = card.search('.review-star-text').text.strip
      ratings = rating_list.split(":") unless rating_list.nil?
      prep_time_url = card.search('.card__titleLink').attribute('href')
      prep_time_doc = Nokogiri::HTML(URI.open(prep_time_url).read, nil, 'utf-8')
      prep = prep_time_doc.search('.recipe-meta-item').find do |fuckoff|
        fuckoff.text.match(/prep/i)
      end
      prep_time = prep == nil ? nil : prep.text.match(/\s(\d+\smins)/i)[1]
      results << Recipe.new({ name: name, description: description, prep_time: prep_time, ratings: ratings[1] })
    end
    results
  end
end




