module Spree
  class Calculator::StackablePriceSack < Calculator
    preference :limit_amount, :integer, default: 0
    preference :discount_amount, :decimal, default: 0

    attr_accessible :preferred_limit_amount,
                    :preferred_discount_amount

    alias_method :preferred_amount, :preferred_discount_amount

    def self.description
      Spree.t(:stackable_price_sack)
    end

    def compute(object=nil)
      if object.is_a?(Array)
        base_amount = object.map { |o| o.respond_to?(:amount) ? o.amount : BigDecimal(o.to_s) }.sum
      else
        base_amount = object.respond_to?(:amount) ? object.amount : BigDecimal(object.to_s)
      end
      base_amount = preferred_limit_amount.nonzero? ? (base_amount / preferred_limit_amount) : 1
      base_amount.to_i * preferred_discount_amount
    end
  end
end
