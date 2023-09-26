# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: "admin@admin") do |admin|
  admin.password = 'adminadmin'
end

# ユーザーテストデータ
taro = User.find_or_create_by!(email: "taro@example.com") do |user|
  user.name = "taro"
  user.password = "password1"
  user.introduction = %Q{最近トレーニングを始めました！\nよろしくお願いします！}
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/taro.jpg"), filename:"taro.jpg")
end

hanako = User.find_or_create_by!(email: "hanako@example.com") do |user|
  user.name = "hanako"
  user.password = "password2"
  user.introduction = %Q{ヨガと料理が趣味です。\nたくさん投稿します。}
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/hanako.jpg"), filename:"hanako.jpg")
end

takashi = User.find_or_create_by!(email: "takashi@example.com") do |user|
  user.name = "takashi"
  user.password = "password3"
  user.introduction = %Q{筋トレ初心者です。\nよろしくお願いします。}
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/takashi.jpg"), filename:"takashi.jpg")
end

kanako = User.find_or_create_by!(email: "kanako@example.com") do |user|
  user.name = "kanako"
  user.password = "password4"
  user.introduction = "ヨガインストラクター/パーソナルジムトレーナー/エステティシャン"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kanako.jpg"), filename:"kanako.jpg")
end

# フォローテストデータ
taro.follow(hanako.id) if !taro.following?(hanako)

sasami_tag = Tag.find_or_create_by!(name: "ささみ") do |tag|
  tag.name = "ささみ"
end

genryou_tag = Tag.find_or_create_by!(name: "減量") do |tag|
  tag.name = "減量"
end

sasami_recipe = Recipe.find_or_create_by!(title: "ささみの燻製") do |recipe|
  recipe.recipe_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/recipe1.jpg"), filename: "recipe1.jpg")
  recipe.material = %Q{ササミ4本\n塩適量\n粗びき黒こしょう適量\n桜チップ大さじ1.5}
  recipe.process = %Q{1.ささみに縦に切り込みを入れて開き、両面に塩・こしょうを振ります。\n
  2.1を干し網などで半日〜1日干します。\n
  3.燻製器に桜チップと3をセットし、火にかけます。煙がたってきたら蓋をし、7〜8分燻します。\n
  4.火を止め、そのまま4〜5分燻して、できあがりです。}
  recipe.user = taro
  recipe.tags << sasami_tag
  recipe.tags << genryou_tag
end

Comment.find_or_create_by!(user_id: hanako.id) do |comment|
  comment.comment = "美味しそうですね。"
  comment.recipe_id = sasami_recipe.id
end

Favorite.find_or_create_by!(user_id: hanako.id) do |favorite|
  favorite.recipe_id = sasami_recipe.id
end