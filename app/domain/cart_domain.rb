class CartDomain
  def self.get_products_number user
    @cart = user.cart

    if @cart
      @cart.line_items.count
    else
      0
    end
  end

  def self.get_total_price user
    @cart = user.cart
    @cart.reload

    if @cart
      @cart.line_items.inject(0) do |totle_price, line_item|
        totle_price + line_item.price * line_item.quantity
      end
    else
      0
    end
  end
end
