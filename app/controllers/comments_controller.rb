#coding: UTF-8
class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    @product = Product.find params[:product_id]

    @comments = @product.comments.page(params[:page]).per(15)

    respond_to  do |format|
      format.js {render}
    end
  end

  def new
    @order = current_user.orders.find params[:order_id]
  end

  def create
    line_item = current_user.line_items.find params[:line_item_id]

    if line_item.comment.present?
      return redirect_to :back, alert: "你只能评论一次"
    end

      comment = line_item.build_comment context: params[:context], product_id: line_item.product_id, user_id: current_user.id

      if comment.save
        return redirect_to :back, notice: "评论成功"
      else
        return redirect_to :back, alert: comment.errors.full_messages.to_sentence
      end
  end

  def destroy
    comment = current_user.comments.find params[:id]

    if comment.destroy
      return redirect_to :back, notice: "成功删除评论."
    else
      return redirect_to :back, alert:  "删除评论失败"
    end
  end
end
