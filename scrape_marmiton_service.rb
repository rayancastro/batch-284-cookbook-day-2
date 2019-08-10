require 'open-uri'
require 'nokogiri'

class ScrapeMarmitonService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # Set the URL with the keyword
    url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@keyword}"
    # Open the URL using a keyword
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    # Parse the HTML, extract the first 5 recipes and store them in a list
    results = []
    html_doc.search('.recipe-card').first(5).each do |recipe_card|
      recipe_name = recipe_card.search('.recipe-card__title').text
      recipe_description = recipe_card.search('.recipe-card__description').text.strip
      recipe_prep_time = recipe_card.search('.recipe-card__duration__value').text

      results << Recipe.new(name: recipe_name, description: recipe_description, prep_time: recipe_prep_time)
    end
    return results
  end
end
