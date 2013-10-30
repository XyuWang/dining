class MapsController < ApplicationController
  def show
    @start_end = params[:start_end]
    @finish_end = params[:finish_end]

    respond_to do |format|
      format.js
    end
  end
end
