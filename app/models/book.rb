# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader

  has_many :comments, -> { order(:created_at, :id) }, as: :commentable, inverse_of: :commentable, dependent: :destroy
end
