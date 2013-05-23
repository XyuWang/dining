#coding: UTF-8
class CartController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_cart

  def add_product
    product = Product.find params[:product_id]
    line_item = @cart.line_items.new product_id: product.id
    line_item.quantity = 1
    line_item.price = product.price

    if @cart.save
      redirect_to :back, notice: "成功"
    else
      redirect_to :back, alert: @cart.errors.full_messages.to_sentence
    end
  end

  def remove_product
    line_item = @cart.line_items.find params[:line_item_id]

    if line_item.destroy
      redirect_to :back, notice: "成功"
    else
      redirect_to :back, alert: line_item.errors.full_messages.to_sentence
    end
  end

  def show
  end

  private
  def load_cart
    @cart = current_user.cart
    @cart ||= current_user.create_cart
  end
end
