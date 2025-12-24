# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者データの作成
Admin.find_or_create_by!(email: "admin@example.com") do |admin|
    admin.name = "管理者太郎"
    admin.password = "password123" # ログイン時に使用
  end
  
  # 一般ユーザー（テスト用）の作成
  User.find_or_create_by!(email: "test@example.com") do |user|
    user.name = "テストユーザー"
    user.password = "password123"
    user.introduction = "初めまして。自転車が大好きです。"
    user.is_active = true
  end
  
  Genre.find_or_create_by!(name: "ロードバイク")
  Genre.find_or_create_by!(name: "MTB")
  Genre.find_or_create_by!(name: "クロスバイク")
  
  puts "Seedデータの作成が完了しました！"