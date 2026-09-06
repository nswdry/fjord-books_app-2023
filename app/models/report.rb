# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioning_relations, class_name: 'ReportMention',
                                  foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioning_reports, through: :mentioning_relations, source: :mentioned_report

  has_many :mentioned_relations, class_name: 'ReportMention',
                                 foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :mentioned_relations, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  after_save :sync_report_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def sync_report_mentions
    content_ids = extract_mentioned_report_ids
    saved_ids = mentioning_relations.pluck(:mentioned_report_id)

    (saved_ids - content_ids).each do |mentioned_id|
      mentioning_relations.find_by(mentioned_report_id: mentioned_id).destroy
    end

    (content_ids - saved_ids).each do |mentioned_id|
      mentioning_relations.create!(mentioned_report_id: mentioned_id)
    end
  end

  def extract_mentioned_report_ids
    ids = content.to_s.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.map(&:to_i).uniq
    ids.delete(id)
    Report.where(id: ids).pluck(:id)
  end
end
