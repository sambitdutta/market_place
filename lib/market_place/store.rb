module MarketPlace
  class Store
    attr_reader :promotions, :products

    def initialize
      @promotions = []
      @products = []
    end

    def self.configure
      yield store_config if block_given?
    end

    def add(type, item)
      # require 'byebug'
      # byebug
      case type
      when :promotion
        (@promotions ||= []) << item
      when :product
        (@products ||= []) << item
      else
        fail 'unknown type'
      end
    end

    def self.promotions
      store_config.promotions
    end

    def self.products
      store_config.products
    end

    private

    def self.store_config
      @store_config ||= self.new
    end
  end
end
