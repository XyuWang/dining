#coding: UTF-8
class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def create
    @order = current_user.orders.new message: params[:message]
    @cart = current_user.cart

    @order.line_items = @cart.line_items

    if @order.save
      @cart.line_items.destroy_all
      return redirect_to :back, notice: "成功下单！"
    else
      return redirect_to :back, alert: @order.errors.full_messages.to_sentence
    end
  end
end
