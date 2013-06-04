#coding: UTF-8
class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
  end

  def update
    current_user.name = params[:name] if params[:name]
    current_user.address = params[:address] if params[:address]
    current_user.phone = params[:phone] if params[:phone]

    if current_user.save
      redirect_to :back, notice:"更新成功!" and return
    else
      render action: :show, alert:"更新失败!" and return
    end
  end
end
