# freemarket_sample_65e DB設計
![ER図](https://i.imgur.com/mmk3nit.jpg)

## usersテーブル
| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| nickname             | string  | null: false |
| image                | text    |             |
| evaluation           | integer |             |
| email                | string  |             |
| encrypted_password   | string  |             |
| evaluation           | integer |             |
| reset_password_token | string  |             |
| name                 | string  |             |


### Association
- has_one :user_detail
- has_many :products
- has_many :likes
- has_many :messages
- has_many :cards
- has_many :sns_credentials

# user_detailsテーブル
| Column         | Type    | Options             |
| -------------- | ------- | ------------------- |
| user_id        | string  | null: false         |
| email          | string  | null: false, unique |
| password       | string  | null: false         |
| first_name     | string  | null: false         |
| first_kana     | string  | null: false         |
| last_name      | string  | null: false         |
| last_kana      | string  | null: false         |
| year           | integer | null: false         |
| month          | integer | null: false         |
| day            | integer | null: false         |
| post_num       | integer | null: false         |
| municipalities | string  | null: false         |
| build_name     | string  |                     |
| comment        | text    |                     |
| prefecture_id  | string  |                     |
| phone_num      | string  |                     |
| adress         | integer |                     |
### Association
- belongs_to :user

## productsテーブル
| Column        | Type    | Options                        |
| ------------- | ------- | ------------------------------ |
| title         | string  | null: false                    |
| price         | integer | null: false                    |
| info          | text    |                                |
| status        | integer | null: false                    |
| postage       | text    | null: false                    |
| shipping      | text    | null: false                    |
| from          | string  | null: false                    |
| day           | string  | null: false                    |
| brand_id      | integer | foreign_key: true              |
| category_id   | integer | null: false, foreign_key: true |
| user_id       | integer | null: false, foreign_key: true |
| parchaser_id  | integer |                                |
| prefecture_id | integer |                                |
### Association
- belongs_to :category
- belongs_to :brand
- belongs_to :user
- has_many :images
- has_many :messages
- has_many :likes

## categoriesテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| ancestry | string | null: false |
### Association
- has_ancestry

## messagesテーブル
| Column     | Type    | Options                        |
| ---------- | ------- | ------------------------------ |
| message    | text    |                                |
| user_id    | integer | null: false, foreign_key: true |
| product_id | integer | null: false, foreign_key: true |
### Association
- belongs_to :user
- belongs_to :product

## imagesテーブル
| Column     | Type    | Options                        |
| ---------- | ------- | ------------------------------ |
| images     | text    | null: false                    |
| product_id | integer | null: false, foreign_key: true |
### Association
- belongs_to :product

## brandsテーブル
| Column | Type | Options |
| ------ | ---- | ------- |
| brand  | text |         |
### Association
- has_many :products

## likesテーブル
| Column     | Type    | Options                        |
| ---------- | ------- | ------------------------------ |
| nice       | integer |                                |
| user_id    | integer | null: false, foreign_key: true |
| product_id | integer | null: false, foreign_key: true |
### Association
- belongs_to :product
- belongs_to :user

## cardテーブル
| Column      | Type    | Options |
| ----------- | ------- | ------- |
| user_id     | integer |         |
| customer_id | integer |         |
| card_id     | string  |         |
### Association
- belongs_to :user

## sns_credentialテーブル
| Column   | Type    | Options |
| -------- | ------- | ------- |
| user_id  | integer |         |
| provider | string  |         |
| uid      | string  |         |
### Association
- belongs_to :user