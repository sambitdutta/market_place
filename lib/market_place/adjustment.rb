module MarketPlace
  class Adjustment
    attr_accessor :source, :adjustable, :amount

    def initialize(source:, adjustable:, amount:)
      @source, @adjustable, @amount = source, adjustable, amount
    end
  end
end
