class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_admin

  def show
  end

  private
  def ensure_user_is_admin
    authorize! :manage, :all
  end
end
