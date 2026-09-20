# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable? 本人なら編集できる' do
    report = reports(:one)

    assert report.editable?(report.user)
  end

  test '#editable? 本人以外は編集できない' do
    report = reports(:one)

    assert_not report.editable?(users(:two))
  end

  test '#created_on 日付を返す' do
    report = reports(:one)

    assert_equal report.created_at.to_date, report.created_on
  end

  test '#save_mentions 本文に他のreportのURLがあればmentioning_reportsに追加' do
    target = reports(:two)
    report = reports(:one)

    report.update!(content: "http://localhost:3000/reports/#{target.id}")

    assert_includes report.mentioning_reports, target
  end

  test '#save_mentions 本文に他reportsのURLがなければmentioning_reportsなし' do
    report = reports(:one)

    report.update!(content: 'こんにちは')

    assert_empty report.mentioning_reports
  end

  test '#save_mentions 言及先を変更するとmentioning_reportsも更新される' do
    target1 = reports(:two)
    target2 = reports(:three)
    report = reports(:one)

    report.update!(content: "http://localhost:3000/reports/#{target1.id}")
    assert_includes report.mentioning_reports, target1

    report.update!(content: "http://localhost:3000/reports/#{target2.id}")

    report.reload
    assert_includes report.mentioning_reports, target2
    assert_not_includes report.mentioning_reports, target1
  end
end
