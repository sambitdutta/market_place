require_relative '../promotion_rule'
require_relative '../adjustment'

module MarketPlace
  module PromotionRules
    class ReducedPriceOnItem < MarketPlace::PromotionRule
      QUANTITY = 2.freeze
      DISCOUNT = 0.75.freeze

      def initialize(checkout:, line_item:)
        super
      end

      def eligible?
        return false unless line_item.is_a?(MarketPlace::LineItem)
        return false unless line_item.product.code == '001'

        line_item.quantity >= QUANTITY
      end

      def actionable?
        eligible?
      end

      def perform
        update_adjustment
        register_adjustment
      end

      private

      def update_adjustment
        self.class.adjustment ||= Adjustment.new(source: self, adjustable: line_item, amount: - (QUANTITY - 1) * DISCOUNT)
        self.class.adjustment.amount -= DISCOUNT
        self.class.adjustment.adjustable = line_item
      end

      def register_adjustment
        checkout.adjustments << self.class.adjustment
      end
    end
  end
end
