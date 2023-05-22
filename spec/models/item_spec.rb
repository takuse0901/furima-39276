require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できるとき' do
      it 'item_name、caption、category_id、condition_id、delivery_charge_id、prefecture_id、delivery_day_id、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できないとき' do
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'captionが空では登録できない' do
        @item.caption = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Caption can't be blank")
      end
      it 'categoryが空では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'conditionが空では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'delivery_chargeが空では登録できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end
      it 'prefectureが空では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'delivery_dayが空では登録できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceに半角数字以外が含まれていたら出品できない' do
        @item.price = '１１１1'
        @item.valid?
        expect(@item.errors.full_messages).to include ('Price is not a number')
      end
      it 'priceは小数点を含む数値では保存できない' do
        @item.price = 555.5
        @item.valid?
        expect(@item.errors.full_messages).to include ('Price must be an integer')
      end
      it 'priceが300円以下では保存できない' do
        @item.price = 111
        @item.valid?
        expect(@item.errors.full_messages).to include ('Price must be greater than or equal to 300')
      end
      it 'priceが9999999円以上では保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include ('Price must be less than or equal to 9999999')
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
