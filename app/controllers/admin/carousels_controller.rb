# coding: UTF-8
class Admin::CarouselsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_admin

  def index
    @carousels = Carousel.all
  end

  def new
    @carousel = Carousel.new
  end

  def edit
    @carousel = Carousel.find params[:id]
  end

  def create
    @carousel = Carousel.new params[:carousel]

    if @carousel.save
      redirect_to admin_carousels_path, notice: "成功!"
    else
      redirect_to :back, alert: @carousel.errors.full_messages.to_sentence
    end
  end

  def destroy
    @carousel = Carousel.find params[:id]

    if @carousel.destroy
      redirect_to admin_carousels_path, notice: "成功!"
    else
      redirect_to :back, alert: @carousel.errors.full_messages.to_sentence
    end

  end

  def update
    @carousel = Carousel.find params[:id]
    if @carousel.update_attributes params[:carousel]
      redirect_to admin_carousels_path, notice: "成功!"
    else
      redirect_to :back, alert: @carousel.errors.full_messages.to_sentence
    end
  end

  private
  def ensure_user_is_admin
    authorize! :manage, :all
  end
end
