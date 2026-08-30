# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: :create
  before_action :set_comment, only: :destroy
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable,
                  notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @commentable,
                  alert: t('views.common.validation_error', name: Comment.model_name.human, errors: @comment.errors.full_messages.join('、'))
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
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
