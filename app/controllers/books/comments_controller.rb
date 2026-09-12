# frozen_string_literal: true

module Books
  class CommentsController < ApplicationController
    include CommentableActions

    private

    def set_commentable
      @commentable = Book.find(params[:book_id])
    end
  end
end
