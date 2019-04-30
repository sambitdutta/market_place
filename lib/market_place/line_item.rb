module MarketPlace
  class LineItem
    attr_accessor :product, :quantity

    def initialize(product:, quantity:)
      @product, @quantity = product, quantity
    end
  end
end
