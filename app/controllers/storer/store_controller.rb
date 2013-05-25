# coding: UTF-8
class Storer::StoreController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_storer
  before_filter :load_store

  def open
    @store.opening
    redirect_to :back
  end

  def close
    @store.close
    redirect_to :back
  end

  private
  def ensure_user_is_storer
    authorize! :manage, :store
  end

  def load_store
    @store = current_user.store
    @store ||= current_user.build_store
  end
end
