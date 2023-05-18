require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、nameとsei、kana_nameとkana_sei、birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it '英字のみのpasswordは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it '数字のみのpasswordは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it '全角文字のあるpasswordは登録できない' do
        @user.password = 'aaaa１２'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name is invalid")
      end
      it '半角文字が含まれているとnameは登録できない' do
        @user.name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include ('Name is invalid')
      end
      it 'seiが空では登録できない' do
        @user.sei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Sei is invalid")
      end
      it '半角文字が含まれているとseiは登録できない' do
        @user.sei = 'bbbb'
        @user.valid?
        expect(@user.errors.full_messages).to include ('Sei is invalid')
      end
      it 'kana_nameが空では登録できない' do
        @user.kana_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name is invalid")
      end
      it 'カタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれているとkana_nameが登録できない' do
        @user.kana_name = 'test/'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana name is invalid")
      end
      it 'kana_seiが空では登録できない' do
        @user.kana_sei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana sei is invalid")
      end
      it 'カタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれているとkana_seiが登録できない' do
        @user.kana_sei = 'test/'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana sei is invalid")
      end
      it 'birthが空では登録できない' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end
