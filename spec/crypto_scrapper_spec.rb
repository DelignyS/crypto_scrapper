require 'rspec'
require_relative '../lib/crypto_scrapper.rb'  # Remplacez par le nom de votre fichier de programme

describe 'crypto_scraper' do
  it 'returns an array of 15 most expensive cryptocurrencies' do
    crypto_list = crypto_scraper
    expect(crypto_list).to be_an(Array)
    expect(crypto_list.length).to eq(15)
    crypto_list.each do |crypto|
      expect(crypto).to be_a(Hash)
      crypto.each do |name, price|
        expect(name).to be_a(String)
        expect(price).to be_a(Float)
        expect(price).to be > 0
      end
    end
  end
end