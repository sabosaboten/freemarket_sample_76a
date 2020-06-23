# README

<h1 align="center">フリーマーケットサイト</h1>

- メルカリクローンのフリーマーケットサイトです。
- TECH::CAMP 76期短期集中コースAチームで作成。
- 作成期間 2020/6/2 ~ 2020/6/23
[![Image from Gyazo](https://i.gyazo.com/9cc134e9089d33d74bdd287f377a3d55.jpg)](https://gyazo.com/9cc134e9089d33d74bdd287f377a3d55)
[![Image from Gyazo](https://i.gyazo.com/f498e9a1834f4aaa5c3dfd60a0b8a412.jpg)](https://gyazo.com/f498e9a1834f4aaa5c3dfd60a0b8a412)
## :paperclip: 主な使用言語
<a><img src="https://user-images.githubusercontent.com/39142850/71774533-1ddf1780-2fb4-11ea-8560-753bed352838.png" width="70px;" /></a> <!-- rubyのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774548-731b2900-2fb4-11ea-99ba-565546c5acb4.png" height="60px;" /></a> <!-- RubyOnRailsのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774618-b32edb80-2fb5-11ea-9050-d5929a49e9a5.png" height="60px;" /></a> <!-- Hamlのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774644-115bbe80-2fb6-11ea-822c-568eabde5228.png" height="60px" /></a> <!-- Scssのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774768-d064a980-2fb7-11ea-88ad-4562c59470ae.png" height="65px;" /></a> <!-- jQueryのロゴ -->
<a><img src="https://user-images.githubusercontent.com/39142850/71774786-37825e00-2fb8-11ea-8b90-bd652a58f1ad.png" height="60px;" /></a> <!-- AWSのロゴ -->

## 機能紹介
- 新規会員登録・ログイン機能
- ログイン時の商品の出品、商品の編集機能
- ログインしていない方でも商品の一覧、詳細を閲覧可能です。
- 住所、クレジットカード登録後商品の購入ができます。
- 自分が出品した商品をマイページで確認できます。

## 実装内容の紹介
- 商品情報編集機能
- 商品詳細表示機能
- 商品削除機能
- 商品出品機能
- ユーザー新規登録、ログイン機能
- カテゴリー機能
- 商品購入機能
- 商品一覧表示機能

## サイトURL紹介
- ユーザー名:admin
- パスワード:password
- IPアドレス:http://3.115.42.47/

# :page_facing_up: DB設計

## ER図

## destinationテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|post_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building_name|string|
|phone_number|string|
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture
## cardテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user
## brandテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|index: true|
|item_id|integer|oreign_key: true|
### Association
- has_many :items
## imageテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item
## itemsテーブル
|Column|Type|Options|Options|
|------|----|-------|-------|
|seller|integer|null: false|foreign_key: true|
|buyer|integer|foreign_key: true|
|name|string|null: false|
|description|string|null: false|
|price|integer|null: false|
|category_id|integer|null: false|foreign_key: true|
|brand_id|integer|foreign_key: true|
|status|integer|null: false|
|cost|integer|null: false
|prefecture_id|integer|null: false|
|days|integer|null: false|
### Association
- belongs_to :seller, class_name: “user”, foreign_key: “seller_id”
- belongs_to :buyer, class_name: “user”, foreign_key: “buyer_id”
- belongs_to :category dependent: :destroy
- belongs_to :brand dependent: :destroy
- has_many :images dependent: :destroy
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :status
- belongs_to_active_hash :cost
- belongs_to_active_hash :days
## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|
### Association
- has_many :items
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_day|date|null: false|
### Association
- has_many :destination dependent: :destroy
- has_many :card dependent: :destroy
- has_many :items dependent: :destroy
- has_many :selling_items, -> { where("seller_id is not NULL && buyer_id is NULL") }, class_name: "Item"
- has_many :bought_items, class_name: "Item", foreign_key: "buyer_id"
- has_many :sold_items, -> { where("buyer_id is not NULL") }, class_name: "Item"

