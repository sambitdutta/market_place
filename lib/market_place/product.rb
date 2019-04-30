module MarketPlace
  class Product
    attr_reader :code, :name, :price

    def initialize(code:, name:, price:)
      @code, @name, @price = code, name, price
    end
  end
end
