class StoresController < ApplicationController

  def index
    @stores = Store.all
  end

  def show
    @store = Store.find params[:id]
    @products = @store.products.up.page(params[:page]).per(8)
  end
end
