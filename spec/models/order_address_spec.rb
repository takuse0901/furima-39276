require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, item_id: item.id, user_id: user.id)
      sleep 0.1
    end

    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できない' do
        @order_address.postcode = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Postcode can't be blank"
      end
      it 'postcodeに半角ハイフンが正しい位置になければ保存できない' do
        @order_address.postcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Postcode is invalid. Include hyphen(-)'
      end
      it 'postcodeが全角では保存できない' do
        @order_address.postcode = '１２３−４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Postcode is invalid. Include hyphen(-)'
      end
      it 'prefectureが空では登録できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'telが空だと保存できない' do
        @order_address.tel = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel can't be blank")
      end
      it 'telが9桁以下だと保存できない' do
        @order_address.tel = '12345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel is invalid")
      end
      it 'telが12桁以上だと保存できない' do
        @order_address.tel = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel is invalid")
      end
      it 'telが全角だと保存できない' do
        @order_address.tel = '１２３４５-６７８９０'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Tel is invalid"
      end
      it 'userが紐付いていないと保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空だと保存できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end