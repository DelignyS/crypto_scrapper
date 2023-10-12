require 'rspec'
require_relative '../lib/crypto_scrapper.rb' 

describe 'top_10_crypto_scraper' do
  it 'returns an array with data for the top 10 cryptocurrencies' do
    crypto_data = top_10_crypto_scraper

    #1
    expect(crypto_data).to be_an(Array)

    #2
    expect(crypto_data.length).to be >= 10

    #3
    crypto_data.each do |crypto|
      expect(crypto).to be_a(Hash)
      expect(crypto).to have_key(:name)
      expect(crypto).to have_key(:price)
    end
  end
end
