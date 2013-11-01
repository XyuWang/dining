# coding: UTF-8
class Storer::CreditsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_storer
  before_filter :load_orders

  def add
    @order.store_evaluated!
    user = @order.user
    user.credit += 1
    if user.save
      redirect_to :back, notice: "评价成功"
    else
      redirect_to :back, notice: "评价失败"
    end
  end

  def sub
    @order.store_evaluated!
    user = @order.user
    user.credit -= 1
    if user.save
      redirect_to :back, notice: "评价成功"
    else
      redirect_to :back, notice: "评价失败"
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

    @order = @store.orders.find params[:order_id]

    if @order.store_evaluated?
      return redirect_to :back, alert: "不能重复评价"
    end
  end
end
