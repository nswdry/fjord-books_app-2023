# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)

    visit root_url
    fill_in 'Eメール', with: 'one@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test '日報の一覧が表示される' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test '日報を新規作成できる' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'lsコマンドむずすぎへん？'
    fill_in '内容', with: '実装めちゃくちゃ難しい！'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '実装めちゃくちゃ難しい！'
    assert_text 'lsコマンドむずすぎへん？'
    click_on '日報の一覧に戻る'
  end

  test '日報を編集できる' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: '更新タイトル'
    fill_in '内容', with: '更新内容'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '更新タイトル'
    assert_text '更新内容'
    click_on '日報の一覧に戻る'
  end

  test '日報を削除できる' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
    assert_no_text @report.title
  end
end
