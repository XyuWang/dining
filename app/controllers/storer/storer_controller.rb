class Storer::StorerController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_storer

  def edit

  end

  def show
    
  end

  private
  def ensure_user_is_storer
    authorize! :manage, :store
  end
end
