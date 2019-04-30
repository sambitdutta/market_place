require 'thor'
require 'tty-prompt'
require_relative 'checkout'
require_relative 'promotion_handler'

module MarketPlace
  class CLI < Thor
    desc "start", "Start Shopping"
    def start
      puts "Welcome to Sambit's Market place"

      prompt = TTY::Prompt.new
      continue = true
      market_place = Checkout.new(promotion_rules: Store.promotions)
      PromotionHandler.new(market_place)

      while continue
        code = prompt.select('Pick item') do |menu|
          Store.products.each do |product|
            menu.choice product.name, product.code
          end
        end

        product = Store.products.detect { |p| p.code == code }
        market_place.scan(product)

        continue = prompt.yes?('Do you wish to continue?')
      end

      puts "Total: #{market_place.total}"
    end
  end
end
