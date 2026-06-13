# frozen_string_literal: true

module ApplicationHelper
  def pluralize_with_locale(word)
    I18n.locale == :ja ? word : word.pluralize
  end
end
