# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効な属性であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'ユーザー名が空欄でないこと' do
      user = build(:user, name: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'ユーザー名の日本語入力が無効であること' do
      user = build(:user, name: 'テストユーザー')
      expect(user).to be_invalid
      expect(user.errors[:name]).to include('は半角英数字で入力してください')
    end

    it '重複したユーザー名は無効であること' do
      create(:user, name:'testuser')
      user = build(:user, name: 'testuser')
      expect(user).to be_invalid
      expect(user.errors[:name]).to include('は既に存在します')
    end

    it 'メールアドレスが空欄でないこと' do
      user = build(:user, email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include('を入力してください')
    end

    it '重複したメールアドレスは無効であること' do
      create(:user, email:'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).to be_invalid
      expect(user.errors[:email]).to include('は既に存在します')
    end

    it '5文字以下のパスワードは無効であること' do
      user = build(:user, password: 'a' * 5)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end
  end


end