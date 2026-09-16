# frozen_string_literal: true

module CommentsHelper
  def display_name_or_email(user)
    user.name.presence || user.email
  end
end
