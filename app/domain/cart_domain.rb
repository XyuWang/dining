class CartDomain
  def self.get_products_number user
    @cart = user.cart

    if @cart
      @cart.line_items.count
    else
      0
    end
  end
end
