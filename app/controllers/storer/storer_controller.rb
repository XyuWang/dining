# coding: UTF-8
class Storer::StorerController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_storer
  before_filter :load_store

  def show
  end

  def update
    @store.update_attributes params[:store]

    if @store.save
      redirect_to :back, notice: "成功"
    else
      redirect_to :back, alert: @store.errors.full_messages.to_sentence
    end
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
