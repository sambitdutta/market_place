require_relative 'utils/helper'
Dir[File.dirname(__FILE__) + '/promotion_rules/*.rb'].each { |file| require file }

module MarketPlace
  class PromotionHandler
    attr_accessor :checkout

    include Utils::Helper

    def initialize(checkout)
      @checkout = checkout
      checkout.add_observer(self)
    end

    def update(line_item)
      perform_adjustments(checkout, line_item)
    end
  end
end
