#coding: UTF-8
class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    @product = Product.find params[:product_id]

    @comments = @product.comments
    render :layout => false
  end

  def create
    line_item = current_user.line_items.find params[:line_item_id]

    if line_item.comment.present?
      return redirect_to :back, alert: "你只能评论一次"
    end

      line_item.build_comment context: params[:context], product_id: line_item.product_id

      if line_item.save
        return redirect_to :back, notice: "评论成功"
      else
        return redirect_to :back, alert: line_item.errors.full_messages.to_sentence
      end
  end
end
