require 'rails_helper'
require 'securerandom'
RSpec.describe 'User機能のテスト', type: :system do
  describe 'ログインしていない場合のテスト' do
    context 'ユーザーがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit '/'
        expect(page).to have_content 'Login'
      end
    end
    context 'ユーザーがログインせずユーザ情報画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit '/users/account'
        expect(page).to have_content 'Login'
      end
    end
    context 'ユーザーがログインせずユーザ情報編集画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit '/users/edit'
        expect(page).to have_content 'Login'
      end
    end
  end

  describe 'サインアップ機能' do
    context 'ユーザーを新規登録した場合' do
      it 'タスクスケジュール画面に遷移する' do
        visit '/users/signup'
        fill_in "name", with: 'rspec太郎'
        fill_in "email", with: 'rspec@rspec.jp'
        fill_in "password", with: 'password'
        fill_in "confirm_password", with: 'password'
        click_on("Sign up")
        expect(page).to have_content 'タスク一覧'
      end
    end
   
  end
  describe 'ユーザー情報確認機能' do
    before do
      visit '/users/signup'
      fill_in "name", with: 'testuser'
      fill_in "email", with: 'test@test.jp'
      fill_in "password", with: 'password'
      fill_in "confirm_password", with: 'password'
      click_on("Sign up")
    end
    context 'ログイン後に遷移したタスクスケジュール画面のメニューからユーザー情報を押下' do
      it '  ユーザー情報画面に遷移する' do
        visit '/users/login'
        fill_in "email", with: 'test@test.jp'
        fill_in "password", with: 'password'
        click_on("Login")
        find('#menu').click
        click_on("ユーザー情報")
        expect(page).to have_content 'ユーザー情報'
        expect(page).to have_content 'ユーザー名'
        expect(page).to have_content 'EMAIL'
      end
    end
  end

  describe 'ユーザー情報編集機能' do
    before do
      visit '/users/signup'
      fill_in "name", with: 'testuser'
      fill_in "email", with: 'test@test.jp'
      fill_in "password", with: 'password'
      fill_in "confirm_password", with: 'password'
      click_on("Sign up")
    end
    context 'ログイン後にユーザー情報→ユーザー情報編集' do
      it '  ユーザー情報を更新できる' do
        visit '/users/login'
        fill_in "email", with: 'test@test.jp'
        fill_in "password", with: 'password'
        click_on("Login")
        find('#menu').click
        click_on("ユーザー情報")
        click_on('edit')
        fill_in "name", with: 'editeduser'
        fill_in "email", with: 'edit@edit.jp'
        fill_in "password", with: 'editpassword'
        fill_in "confirm_password", with: 'editpassword'
        # binding.irb
        click_on('update')
        expect(page).to have_content 'ユーザー情報'
        expect(page).to have_content 'ユーザー名'
        expect(page).to have_content 'EMAIL'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      visit '/users/signup'
      fill_in "name", with: 'testuser'
      fill_in "email", with: 'test@test.jp'
      fill_in "password", with: 'password'
      fill_in "confirm_password", with: 'password'
      click_on("Sign up")
    end
    context 'ログイン画面で登録済みのemailとパスワードを入力してログイン' do
      it 'タスクスケジュール画面に遷移する' do
        visit '/users/login'
        fill_in "email", with: 'test@test.jp'
        fill_in "password", with: 'password'
        click_on("Login")
        expect(page).to have_content 'タスク一覧'
      end
    end
  end
  describe 'ログアウト機能' do
    before do
      visit '/users/signup'
      fill_in "name", with: 'testuser'
      fill_in "email", with: 'test@test.jp'
      fill_in "password", with: 'password'
      fill_in "confirm_password", with: 'password'
      click_on("Sign up")
    end
    context 'ログイン後に遷移したタスクスケジュール画面のメニューからログアウトを押下' do
      it 'ログアウトしログイン画面に遷移する' do
        visit '/users/login'
        fill_in "email", with: 'test@test.jp'
        fill_in "password", with: 'password'
        click_on("Login")
        find('#menu').click
        click_on("ログアウト")
        expect(page).to have_content 'Login'
      end
    end
  end

end