# テーブル設計

## users テーブル

| Column             | Type    | Options                 |
| ------------------ | ------- | ----------------------- |
| email              | string  | null: false, unique_key |
| encrypted_password | string  | null: false             |
| nickname           | string  | null: false             |
| name               | string  | null: false             |
| sei                | string  | null: false             |
| kana_name          | string  | null: false             |
| kana_sei           | string  | null: false             |
| birth              | date    | null: false             |

### Association
has_many :items
has_many :orders


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| caption            | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| delivery_charge_id | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| delivery_day_id    | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
belongs_to :users
has_one :order
belongs_to :category
belongs_to :condition
belongs_to :delivery_charge_id
belongs_to :delivery_day_id
belongs_to :prefecture_id


## orders テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false  foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :item
has_one :address


## addresses テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postcode           | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| address            | string     | null: false                    |
| building_name      | string     |                                |
| tel                | string     | null: false                    |
| item               | references | null: false, foreign_key: true |

### Association
belongs_to :order
belongs_to :prefecture_id