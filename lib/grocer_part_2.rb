require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = find_item_by_name_in_collection(coupon[:item], cart)
    if item && item[:count] >= coupon[:num]
      discounted_item = {
        item: "#{item[:item]} W/COUPON",
        price: coupon[:cost] / coupon[:num],
        clearance: item[:clearance],
        count: coupon[:num]
      }
      cart << discounted_item
      item[:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  update_cart = cart.map do |item|
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(2)
    end
    item
  end
  update_cart
end

def checkout(cart, coupons)
  update_cart = consolidate_cart(cart)
  update_cart = apply_coupons(update_cart, coupons)
  update_cart = apply_clearance(update_cart)
  total = 0
  update_cart.each { |item| total += item[:price] * item[:count] }
  total > 100 ? (total * 0.9).round(2) : total.round(2)
end
