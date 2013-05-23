class OrderDomain
  def self.get_total_price order
    if order
      order.line_items.inject(0) do |totle_price, line_item|
        totle_price + line_item.price * line_item.quantity
      end
    else
      0
    end
  end
end
