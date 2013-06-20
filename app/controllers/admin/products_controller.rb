# coding: UTF-8
class Admin::ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_admin

  def index
    @products = Product.all
  end

  def new
  end

  def create
    @product = Product.new params[:product]

    if @product.save
      redirect_to admin_products_path, notice: "成功!"
    else
      redirect_to :back, alert: @product.errors.full_messages.to_sentence
    end
  end

  def show

  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]

    @product.update_attributes params[:product]

    if @product.save
      redirect_to :back, notice: "成功!"
    else
      redirect_to :back, alert: @product.errors.full_messages.to_sentence
    end
  end

  def up
    @product = Product.find params[:id]

    if @product.up
      redirect_to :back, notice: "上架成功!"
    else
      redirect_to :back, alert: @product.errors.full_messages.to_sentence
    end
  end

  def down
    @product = Product.find params[:id]

    if @product.down
      redirect_to :back, notice: "下架成功!"
    else
      redirect_to :back, alert: @product.errors.full_messages.to_sentence
    end
  end
  
  private
  def ensure_user_is_admin
    authorize! :manage, :all
  end
end
