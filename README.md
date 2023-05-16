# テーブル設計

## users テーブル

| Column             | Type   | Options                |
| ------------------ | ------ | ---------------------- |
| email              | string | null: false,unique_key |
| encrypted_password | string | null: false            |
| nickname           | string | null: false            |

### Association
has_many :items
has_many :orders


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| caption            | text       | null: false                    |
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| delivery_charge    | string     | null: false                    |
| area               | string     | null: false                    |
| delivery_days      | string     | null: false                    |
| price              | string     | null: false                    |
| seller             | references | null: false, foreign_key: true |

### Association
has_many :users
has_one :order


## orders テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| buyer              | references | null: false  foreign_key: true |
| item               | references | null: false, foreign_key: true |
| price              | references | null: false  foreign_key: true |

### Association
belongs_to :user
belongs_to :item
has_one :address


## address テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| postcode           | string     | null: false |
| pref               | string     | null: false |
| city               | string     | null: false |
| address            | string     | null: false |
| building_name      | text       |             |
| tel                | string     | null: false |

### Association
belongs_to :order