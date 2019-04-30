module MarketPlace
  module Utils
    module Helper
      def eligible_rules(checkout, promotable)
        checkout.promotion_rules.select do |rule|
          Module.const_get(rule).new(checkout: checkout, line_item: promotable).send(
            promotable.is_a?(MarketPlace::Checkout) ? :eligible? : :actionable?)
        end
      end

      def perform_adjustments(checkout, promotable)
        eligible_rules(checkout, promotable).each do |rule|
          Module.const_get(rule).new(checkout: checkout, line_item: promotable).perform
        end
      end
    end
  end
end
