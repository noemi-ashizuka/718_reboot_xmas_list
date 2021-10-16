require 'nokogiri'
require 'open-uri'

def scrape(keyword)
  # filepath = "results.html"
  html_content = URI.open("https://www.etsy.com/search?q=#{keyword}").read

  # 1. We get the HTML page content
  # html_content = File.open(url)

  # 2. We build a Nokogiri document from this file
  doc = Nokogiri::HTML(html_content)
  etsy_results = {}
  # 3. We search for the correct elements containing the items' title in our HTML doc
  doc.search('.v2-listing-card .v2-listing-card__info .v2-listing-card__title').first(5).each do |element|
    # 4. For each item found, we extract its title and print it
    key = element.text.strip.split.first(3).join(' ')
    etsy_results[key] = false
  end
  return etsy_results
end
