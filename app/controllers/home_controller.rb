class HomeController < ApplicationController
  def show
    @stores = Store.all
  end
end
