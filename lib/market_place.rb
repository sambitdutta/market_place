require "market_place/version"
require "market_place/cli"
require "market_place/product"
require "market_place/store"

module MarketPlace
  class Error < StandardError; end

  Store.configure do |config|
    config.add :promotion, 'MarketPlace::PromotionRules::DiscountOnTotal'
    config.add :promotion, 'MarketPlace::PromotionRules::ReducedPriceOnItem'

    config.add :product, Product.new(code: '001', name: 'Lavender heart', price: 9.25)
    config.add :product, Product.new(code: '002', name: 'Personalised cufflinks', price: 45.0)
    config.add :product, Product.new(code: '003', name: 'Kids T-shirt', price: 19.95)
  end
end
