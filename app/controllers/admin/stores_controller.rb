# coding: UTF-8
class Admin::StoresController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_admin

  def index
    @stores = Store.all
  end

  def create
  end

  def show

  end

  def destroy

  end

  private
  def ensure_user_is_admin
    authorize! :admin, :all
  end
end
