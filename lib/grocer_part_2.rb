require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  discounted_cart = []
  coupon_hash = {}
  cart.each_with_index do |hash, i|
    coupons.each do |coupon|
      if coupon[:item] != hash[:item]
        next
      elsif coupon[:item] == hash[:item]
        coupon_hash = {
          :item => hash[:item] + " W/COUPON",
          :price => coupon[:cost] / coupon[:num],
          :clearance => hash[:clearance],
          :count => (hash[:count] / coupon[:num]) * coupon[:num]
        }
        discounted_cart << coupon_hash
        cart[i][:count] %= coupon[:num]
      end  
    end
  end
  cart += discounted_cart
  return cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance] == false
      next
    end
    item[:price] -= (item[:price] * 0.20).round(2)
  end
  return cart
end

def checkout(cart, coupons)
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each do |item|
    total += item[:price] * item[:count]
  end
  if total > 100
    total -= (total * 0.1).round(2)
  end
  return total
end
