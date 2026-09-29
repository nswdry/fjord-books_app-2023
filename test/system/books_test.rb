# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)

    visit root_url
    fill_in 'Eメール', with: 'one@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test '本の一覧が表示される' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test '本を新規作成できる' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'タイトル', with: '楽々ERDレッスン'
    fill_in 'メモ', with: 'テーブル設計を導く画期的な本！'
    fill_in '著者', with: '羽生 章洋'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text '楽々ERDレッスン'
    assert_text 'テーブル設計を導く画期的な本！'
    assert_text '羽生 章洋'
    click_on '本の一覧に戻る'
  end

  test '本を編集できる' do
    visit book_url(@book)
    click_on 'この本を編集'

    fill_in 'タイトル', with: 'チェリー本'
    fill_in 'メモ', with: 'Ruby入門書です。'
    fill_in '著者', with: '伊藤 淳一'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'チェリー本'
    assert_text 'Ruby入門書です。'
    assert_text '伊藤 淳一'
    click_on '本の一覧に戻る'
  end

  test '本を削除できる' do
    visit book_url(@book)
    click_on 'この本を削除'

    assert_text '本が削除されました。'
    assert_no_text @book.title
  end
end
