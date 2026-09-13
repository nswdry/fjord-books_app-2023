# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user

  has_many :comments, -> { order(:created_at, :id) }, as: :commentable, inverse_of: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
