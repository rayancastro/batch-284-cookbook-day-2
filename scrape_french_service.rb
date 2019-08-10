require 'open-uri'
require 'nokogiri'

class ScrapeFrenchService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # Set the URL with the keyword
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{@keyword}"
    # Open the URL using a keyword
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    # Parse the HTML, extract the first 5 recipes and store them in a list
    results = []
    html_doc.search('.m_contenu_resultat').first(5).each do |recipe_card|
      recipe_name = recipe_card.search('.m_titre_resultat a').text
      recipe_description = recipe_card.search('.m_texte_resultat').text.strip
      recipe_prep_time = recipe_card.search('.m_detail_time div')[0].text

      results << Recipe.new(name: recipe_name, description: recipe_description, prep_time: recipe_prep_time)
    end
    return results
  end
end
