# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: :create
  before_action :set_comment, only: :destroy
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable,
                  notice: 'Comment was successfully created.'
    else
      redirect_to @commentable,
                  alert: 'Comment could not be created.'
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_commentable
    @commentable =
      if params[:report_id]
        Report.find(params[:report_id])
      else
        Book.find(params[:book_id])
      end
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
