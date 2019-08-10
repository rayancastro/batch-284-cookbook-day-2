require 'open-uri'
require 'nokogiri'

keyword = "banana"
# Set the URL with the keyword
url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{keyword}"
# Open the URL using a keyword
html_file = open(url).read
# Parse the HTML, extract the first 5 recipes and store them in a list
html_doc = Nokogiri::HTML(html_file)

puts html_doc
