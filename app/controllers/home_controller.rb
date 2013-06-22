class HomeController < ApplicationController
  def show
    @stores = Store.all
    @carousels = Carousel.all
  end
end
