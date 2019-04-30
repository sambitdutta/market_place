module MarketPlace
  class PromotionRule
    attr_reader :checkout, :line_item

    class << self
      attr_accessor :adjustment
    end

    def initialize(checkout:, line_item:)
      @checkout, @line_item = checkout, line_item
    end

    def eligible?
      fail 'should only be implemented by subclasses'
    end

    def actionable?
      fail 'should only be implemented by subclasses'
    end

    def perform
      fail 'should only be implemented by subclasses'
    end
  end
end
