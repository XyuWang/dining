# coding: UTF-8
class Storer::OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_storer
  before_filter :load_orders

  def index
    @orders = @store.orders.page(params[:page]).per(30)
  end

  def accept
    order = @orders.find params[:order_id]

    if order.accept
      redirect_to :back, notice: "接受订单成功"
    else
      redirect_to :back, alert: "失败"
    end
  end

  def deliver
    order = @orders.find params[:order_id]

    if order.deliver
      redirect_to :back, notice: "发货成功"
    else
      redirect_to :back, alert: "失败"
    end
  end

  def close
    order = @orders.find params[:order_id]

    if order.close
      redirect_to :back, notice: "关闭订单成功"
    else
      redirect_to :back, alert: "失败"
    end
  end


  private
  def ensure_user_is_storer
    authorize! :manage, :store
  end

  def load_orders
    @store = current_user.store

    if @store.nil?
      return redirect_to storer_path, alert: "请先建立商店"
    end

    @orders = @store.orders
  end
end
