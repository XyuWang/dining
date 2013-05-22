# coding: UTF-8
class Admin::StorersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_is_admin

  def index
    @storers = User.storers
  end

  def create
    user = User.find params[:user_id]
    user.roles << :storer

    if user.save
      redirect_to :back, notice: "创建商家成功"
    else
      redirect_to :back, alert: user.errors.full_messages.to_sentence
    end
  end

  def show

  end

  def destroy
    user = User.find params[:id]

    roles = user.roles
    roles.delete :storer
    user.roles = roles

    if user.save
      redirect_to :back, notice: "删除商家成功"
    else
      redirect_to :back, alert: user.errors.full_messages.to_sentence
    end
  end

  private
  def ensure_user_is_admin
    authorize! :admin, :all
  end
end
