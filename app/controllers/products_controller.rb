class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find params[:id]

    respond_to  do |format|
      format.html {render layout: false}
    end
  end
end
