# frozen_string_literal: true

module CommentableActions
  extend ActiveSupport::Concern

  included do
    before_action :set_commentable, only: :create
    before_action :set_comment, only: :destroy
  end

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

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
