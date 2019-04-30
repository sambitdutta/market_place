require_relative '../promotion_rule'
require_relative '../adjustment'

module MarketPlace
  module PromotionRules
    class DiscountOnTotal < MarketPlace::PromotionRule
      PRICE_LIMIT = 60.freeze
      DISCOUNT_PERCENTAGE = 10.freeze

      def initialize(checkout:, line_item:)
        super
      end

      def eligible?
        return false unless checkout.is_a?(MarketPlace::Checkout)

        calculate_total > PRICE_LIMIT
      end

      def actionable?
        false
      end

      def perform
        update_adjustment
        register_adjustment
      end

      private

      def calculate_total
        checkout.send(:items_total) + checkout.adjustments.map(&:amount).inject(0, :+)
      end

      def update_adjustment
        self.class.adjustment ||= Adjustment.new(source: self, adjustable: checkout, amount: 0)
        self.class.adjustment.amount = - calculate_total * DISCOUNT_PERCENTAGE / 100
        self.class.adjustment.adjustable = checkout
      end

      def register_adjustment
        checkout.adjustments << self.class.adjustment
      end
    end
  end
end
