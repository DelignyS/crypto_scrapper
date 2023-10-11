require 'nokogiri'
require 'rest-client'

def crypto_scraper
  url = 'https://coinmarketcap.com/all/views/all/' # URL de CoinMarketCap
  response = RestClient.get(url)
  doc = Nokogiri::HTML(response)

  crypto_list = []

  # Scrappez les informations des cryptomonnaies
  doc.css('tbody tr').each do |crypto_row|
    crypto_name = crypto_row.css('.currency-name').text.strip
    crypto_price = crypto_row.css('.price').text.strip.gsub(/\D/, '').to_f / 100.0 # Convertir le prix en nombre flottant

    # Assurez-vous que les données sont valides
    if !crypto_name.empty? && crypto_price > 0
      crypto_list << { crypto_name => crypto_price }
    end
  end

  # Triez les cryptomonnaies par prix, en ordre décroissant
  sorted_crypto_list = crypto_list.sort_by { |crypto| crypto.values.first }.reverse

  # Récupérez les 15 cryptomonnaies les plus chères
  top_15_cryptos = sorted_crypto_list.take(15)

  return top_15_cryptos
end

# Appel de la fonction pour récupérer les données
cryptos = crypto_scraper

# Affichage des résultats
cryptos.each do |crypto|
  crypto.each do |name, price|
    puts "#{name}: $#{price}"
  end
end