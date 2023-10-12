require 'nokogiri'
require 'rest-client'

def top_10_crypto_scraper
  url = 'https://coinmarketcap.com/all/views/all/' # URL de CoinMarketCap
  response = RestClient.get(url)
  doc = Nokogiri::HTML(response)

  crypto_data = []

  # Utilisez des XPaths pour extraire les noms et les prix des 10 premières cryptomonnaies
  doc.xpath('//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[position() <= 10]').each do |crypto_row| # 10 cap 
    crypto_name = crypto_row.at_xpath('.//td[2]/div/a[2]').text.strip
    crypto_price_element = crypto_row.at_xpath('.//td[5]/div/a/span')
    crypto_price = crypto_price_element.text.strip.gsub(/[^\d.]/, '').to_f

    crypto_data << { name: crypto_name, price: crypto_price }
  end

  return crypto_data
end

# la fonction appel le prix des 10 premières cryptomonnaies
top_10_crypto_data = top_10_crypto_scraper

# les 10 premières cryptomonnaies avec son index, son nom, son prix
top_10_crypto_data.each_with_index do |crypto, index|
  puts "Crypto ##{index + 1}: #{crypto[:name]}, Prix: #{crypto[:price]}"
end





#require 'nokogiri'
#require 'rest-client'

#def top_10_crypto_scraper
  #url = 'https://coinmarketcap.com/all/views/all/' # URL de CoinMarketCap
  #response = RestClient.get(url)
  #doc = Nokogiri::HTML(response)

  #crypto_data = []

  # Utilisez un XPath pour extraire les noms des 10 premières cryptomonnaies
  #crypto_names = doc.xpath('//td[contains(@class, "by__symbol")]').map(&:text)

  # Utilisez un XPath pour extraire les prix des 10 premières cryptomonnaies
  #crypto_prices = doc.xpath('//td[contains(@class, "price")]').map { |price| price.text.gsub(/[^\d.]/, '').to_f }

  # Créez un tableau de hachages associant les noms et les prix
  #crypto_data = crypto_names.zip(crypto_prices).map { |name, price| { name: name, price: price } }

 # return crypto_data
#end

# Appel de la fonction pour récupérer les données des 10 premières cryptomonnaies
#cryptos = top_10_crypto_scraper

# Affichage des résultats
#cryptos.each_with_index do |crypto, index|
 # puts "Crypto ##{index + 1}: #{crypto[:name]}, Prix: $#{crypto[:price]}"
#end
