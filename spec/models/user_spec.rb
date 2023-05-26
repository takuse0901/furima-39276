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
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it '英字のみのpasswordは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it '数字のみのpasswordは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it '全角文字のあるpasswordは登録できない' do
        @user.password = 'aaaa１２'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角名)を入力してください')
      end
      it '半角文字が含まれているとnameは登録できない' do
        @user.name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角名)は不正な値です')
      end
      it 'seiが空では登録できない' do
        @user.sei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角氏)を入力してください')
      end
      it '半角文字が含まれているとseiは登録できない' do
        @user.sei = 'bbbb'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(全角氏)は不正な値です')
      end
      it 'kana_nameが空では登録できない' do
        @user.kana_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角名)を入力してください')
      end
      it 'カタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれているとkana_nameが登録できない' do
        @user.kana_name = 'test/'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角名)は不正な値です')
      end
      it 'kana_seiが空では登録できない' do
        @user.kana_sei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角氏)を入力してください')
      end
      it 'カタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれているとkana_seiが登録できない' do
        @user.kana_sei = 'test/'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(全角氏)は不正な値です')
      end
      it 'birthが空では登録できない' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
