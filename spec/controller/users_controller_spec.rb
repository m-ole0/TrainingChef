# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Public::UsersController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    context 'ユーザーがログインしている場合' do
      it '成功すること' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ユーザーがログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        sign_out user
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'ユーザーがログインしている場合' do
      it '成功すること' do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ユーザーがログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        sign_out user
        get :edit, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #check' do
    context 'ユーザーがログインしている場合' do
      it '成功すること' do
        get :check, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ユーザーがログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        sign_out user
        get :check, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #favorite_recipes' do
    context 'ユーザーがログインしている場合' do
      it '成功すること' do
        get :favorite_recipes, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ユーザーがログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        sign_out user
        get :favorite_recipes, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #following_recipes' do
    context 'ユーザーがログインしている場合' do
      it '成功すること' do
        get :following_recipes, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ユーザーがログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        sign_out user
        get :following_recipes, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'ユーザーがログインしている場合' do
      it 'ユーザー情報が更新されること' do
        new_name = 'newname'
        patch :update, params: { id: user.id, user: { name: new_name } }
        user.reload
        expect(user.name).to eq(new_name)
        expect(response).to redirect_to(user_path)
        expect(flash[:notice]).to eq('ユーザー情報を更新しました。')
      end
      it '無効なデータでは更新できないこと' do
        new_name = ''
        patch :update, params: { id: user.id, user: { name: new_name } }
        user.reload
        expect(user.name).not_to eq(new_name)
      end
    end
    context 'ユーザーがログインしていない場合' do
      it 'ユーザー情報が更新されないこと' do
        sign_out user
        new_name = 'testname'
        patch :update, params: { id: user.id, user: { name: new_name } }
        user.reload
        expect(user.name).not_to eq(new_name)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ユーザーがログインしている場合' do
      it 'ユーザーアカウントが削除されること' do
        expect { delete :destroy, params: { id: user.id }}.to change { User.count }.by(-1)
        expect(flash[:notice]).to eq('ユーザーデータを削除しました。')
      end
    end
    context 'ユーザーがログインしていない場合' do
      it 'ユーザーアカウントが削除されないこと' do
      sign_out user
      expect { delete :destroy, params: { id: user.id }}.not_to change { User.count }
      end
    end
  end

end