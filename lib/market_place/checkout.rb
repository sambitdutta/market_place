require 'observer'
require_relative 'line_item'
require_relative 'utils/helper'

module MarketPlace
  class Checkout
    attr_accessor :promotion_rules, :adjustments, :line_items

    include Observable
    include Utils::Helper

    def initialize(promotion_rules:)
      @promotion_rules = promotion_rules
      @line_items = Array.new
      @adjustments = Set.new
    end

    def scan(item)
      line_item = @line_items.detect { |li| li.product.code == item.code }
      if line_item.nil?
        line_item = LineItem.new(product: item, quantity: 0)
        @line_items.push(line_item)
      end
      line_item.quantity += 1

      changed
      notify_observers(line_item)
    end

    def total
      readjust_adjustments
      # puts line_items.inspect
      # puts adjustments.map(&:amount).inspect
      (items_total + adjustments_total).round(2)
    end

    private

    def items_total
      line_items.inject(0) do |sum, item|
        sum = sum + (item.product.price * item.quantity)
      end
    end

    def adjustments_total
      return 0 if adjustments.empty?
      adjustments.map(&:amount).inject(:+)
    end

    def readjust_adjustments
      perform_adjustments(*[self] * 2)
    end
  end
end
