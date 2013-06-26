# coding: UTF-8
class Admin::StoresController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_admin

  def index
    @stores = Store.all
  end

  def edit
    @store = Store.find params[:id]
  end

  def update
    @store = Store.find params[:id]
    @store.update_attributes params[:store]

    if @store.save
      redirect_to admin_stores_path, notice: "成功"
    else
      redirect_to :back, alert: @store.errors.full_messages.to_sentence
    end
  end



  def open
    @store = Store.find params[:id]

    @store.opening
    redirect_to :back
  end

  def close
    @store = Store.find params[:id]

    @store.close
    redirect_to :back
  end

  private
  def ensure_user_is_admin
    authorize! :admin, :all
  end
end
