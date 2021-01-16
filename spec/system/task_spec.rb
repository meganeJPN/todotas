require 'rails_helper'
require 'securerandom'
RSpec.describe 'Task機能のテスト', type: :system do
  before do
    visit '/users/signup'
      fill_in "name", with: 'testuser'
      fill_in "email", with: 'test@test.jp'
      fill_in "password", with: 'password'
      fill_in "confirm_password", with: 'password'
      click_on("Sign up")
      find('#createTask').click
      fill_in "createTaskContent", with: 'テストタスク01'
      fill_in "createTaskComment", with: 'テストタスクコメント01'
      click_on("作成")
      click_on("閉じる")
  end

  describe 'タスク一覧機能' do
    context 'タスク一覧機能を表示した場合' do
      it 'タスクがタスク一覧に表示される' do
        expect(page).to have_content 'テストタスク01'
      end
    end
  end

  describe 'タスク一覧機能及びタスク作成機能' do
    context 'タスクを新規作成した場合' do
      it 'タスクが作成され、作成したタスクがタスク一覧に表示される' do
        visit '/'
        find('#createTask').click
        fill_in "createTaskContent", with: 'テストタスク02'
        fill_in "createTaskComment", with: 'テストタスクコメント02'
        click_on("作成")
        expect(page).to have_content 'テストタスク02'
      end
    end
  end
  describe 'タスク詳細機能' do
    context '一覧に表示されているタスク名をクリックした場合' do
      it 'タスクの詳細が表示される' do
        visit '/'
        click_on("テストタスク01")
        expect(page).to have_content 'タスク詳細'
      end
    end
  end
  describe 'タスク編集機能' do
    context 'タスク詳細画面でタスク内容を変更して更新を押した場合' do
      it 'タスク内容が更新される' do
        visit '/'
        click_on("テストタスク01")
        fill_in "editTaskContent", with: 'テストタスクコンテント更新完了'
        fill_in "editTaskComment", with: 'テストタスクコメント更新完了'
        click_on("更新")
        expect(page).to have_content 'タスクを更新しました'
        expect(page).to have_content 'テストタスクコンテント更新完了'
      end
    end
  end
  describe 'タスク削除機能' do
    context 'タスク詳細画面で削除を押した場合' do
      it 'タスクが削除される' do
        visit '/'
        click_on("テストタスク01")
        click_on("削除")
        click_on("OK")
        expect(page).to have_content 'タスクを削除しました'
        expect(page).to_not have_content 'テストタスク01'
      end
    end
  end
  describe 'タスク完了機能' do
    context 'タスク一覧で✓ボタンを押した場合' do
      it 'タスクが作業中タブから完了タブに移動する'  do
        Capybara.ignore_hidden_elements = true
        visit '/'
        find('#done_0').click
        expect(page).to have_content 'タスクを完了しました'
        expect(page).to_not have_content 'テストタスク01'
        find('#tab-1').click
        expect(page).to have_content 'テストタスク01'
      end
    end
  end

end