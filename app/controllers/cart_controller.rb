#coding: UTF-8
class CartController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_cart
  before_filter :load_product_and_ensure_in_same_store, only: [:add_product]

  def add_product
    line_item = @cart.line_items.new product_id: @product.id
    line_item.quantity = 1
    line_item.price = @product.price
    @cart.store_id = @product.store.id

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

  def total_price
    total_price = CartDomain.get_total_price(current_user)
    if @cart.store.present?
      free_deliver_price = @cart.store.free_deliver_price
    end

    render json: {total_price: total_price, free_deliver_price: free_deliver_price}
  end

  def update
    line_item = @cart.line_items.find params[:line_item_id]

    quantity = line_item.quantity = params[:quantity]

    if line_item.save
      render json: {state: "successful", quantity: quantity, price: line_item.quantity * line_item.product.price}
    else
      render json: {state: "failed", quantity: quantity, price: line_item.quantity * line_item.product.price}
    end
  end

  private
  def load_cart
    @cart = current_user.cart
    @cart ||= current_user.create_cart
  end

  def load_product_and_ensure_in_same_store
    if @cart.line_items.count == 0
      @cart.store_id = nil
    end

    @product = Product.find params[:product_id]

    if @cart.store_id.present? && @cart.store_id != @product.store.id
      redirect_to :back, alert: "一次只能选购一个商家的产品哦， 如果要选购不同卖家的产品，请先清空购物车哈 ^_^"
    end
  end
end
