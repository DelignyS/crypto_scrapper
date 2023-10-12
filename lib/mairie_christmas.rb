require 'nokogiri'
require 'rest-client'

result = []
base_url = 'http://annuaire-des-mairies.com'
region_url = 'http://annuaire-des-mairies.com/val-d-oise.html'

district_doc_html = Nokogiri::HTML(RestClient.get(region_url))
city_links = district_doc_html.css('a.lientxt')

# Limitez le nombre de mairies à 20
city_links.first(20).each_with_index do |city_link, index|
  city_name = city_link.text.strip
  city_relative_url = city_link['href'].sub(/^\./, '')
  city_url = "#{base_url}/#{city_relative_url}"

  city_doc_html = Nokogiri::HTML(RestClient.get(city_url))

  email_elements = city_doc_html.css('td:contains("Adresse Email")')
  emails = email_elements.map { |element| element.next_element.text.strip }

  emails.each do |email|
    result << { "Index" => index + 1, "Ville" => city_name, "Email" => email }
  end
end

result.each do |data|
  puts "Patelin n°: #{data['Index']}, Ville: #{data['Ville']}, Email: #{data['Email']}"
end
