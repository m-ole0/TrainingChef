# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者データ
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

kento = User.find_or_create_by!(email: "kento@example.com") do |user|
  user.name = "kento"
  user.password = "password5"
  user.introduction = %Q{体重が増えてきたので運動頑張ってます！\n気軽にコメントください！}
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kento.jpg"), filename:"kento.jpg")
end

# フォローテストデータ
taro.follow(hanako.id) if !taro.following?(hanako)
taro.follow(takashi.id) if !taro.following?(takashi)
taro.follow(kanako.id) if !taro.following?(kanako)
taro.follow(kento.id) if !taro.following?(kento)

hanako.follow(taro.id) if !hanako.following?(taro)
hanako.follow(takashi.id) if !hanako.following?(takashi)
hanako.follow(kanako.id) if !hanako.following?(kanako)
hanako.follow(kento.id) if !hanako.following?(kento)

takashi.follow(taro.id) if !takashi.following?(taro)
takashi.follow(hanako.id) if !takashi.following?(hanako)
takashi.follow(kanako.id) if !takashi.following?(kanako)
takashi.follow(kento.id) if !takashi.following?(kento)

kanako.follow(taro.id) if !kanako.following?(taro)
kanako.follow(hanako.id) if !kanako.following?(hanako)
kanako.follow(takashi.id) if !kanako.following?(takashi)
kanako.follow(kento.id) if !kanako.following?(kento)

kento.follow(taro.id) if !kento.following?(taro)
kento.follow(hanako.id) if !kento.following?(hanako)
kento.follow(takashi.id) if !kento.following?(takashi)
kento.follow(kanako.id) if !kento.following?(kanako)

# タグテストデータ
sasami_tag = Tag.find_or_create_by!(name: "ささみ") do |tag|
  tag.name = "ささみ"
end

genryou_tag = Tag.find_or_create_by!(name: "減量") do |tag|
  tag.name = "減量"
end

torimuneniku_tag = Tag.find_or_create_by!(name: "鶏胸肉") do |tag|
  tag.name = "鶏胸肉"
end

sarada_tag = Tag.find_or_create_by!(name: "サラダ") do |tag|
  tag.name = "サラダ"
end

torihamu_tag = Tag.find_or_create_by!(name: "鶏ハム") do |tag|
  tag.name = "鶏ハム"
end

# レシピテストデータ
# レシピ1データ
sasami_kunsei = Recipe.find_or_create_by!(title: "ささみの燻製") do |recipe|
  recipe.recipe_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/recipe1.jpg"), filename: "recipe1.jpg")
  recipe.material = %Q{ササミ(4本)\n塩(適量)\n粗びき黒こしょう(適量)\n桜チップ(大さじ1.5)}
  recipe.process = %Q{1.ささみに縦に切り込みを入れて開き、両面に塩・こしょうを振ります。\n
  2.1を干し網などで半日〜1日干します。\n
  3.燻製器に桜チップと3をセットし、火にかけます。煙がたってきたら蓋をし、7〜8分燻します。\n
  4.火を止め、そのまま4〜5分燻して、できあがりです。}
  recipe.user = taro
  recipe.tags << sasami_tag
  recipe.tags << genryou_tag
end

# いいねテストデータ
Favorite.find_or_create_by!(user_id: hanako.id) do |favorite|
  favorite.recipe_id = sasami_kunsei.id
end

Favorite.find_or_create_by!(user_id: takashi.id) do |favorite|
  favorite.recipe_id = sasami_kunsei.id
end

Favorite.find_or_create_by!(user_id: kanako.id) do |favorite|
  favorite.recipe_id = sasami_kunsei.id
end

Favorite.find_or_create_by!(user_id: kento.id) do |favorite|
  favorite.recipe_id = sasami_kunsei.id
end

# コメントテストデータ
Comment.find_or_create_by!(comment: "美味しそうですね！") do |comment|
  comment.user_id = hanako.id
  comment.recipe_id = sasami_kunsei.id
end

Comment.find_or_create_by!(comment: "参考にさせていただきます。") do |comment|
  comment.user_id = takashi.id
  comment.recipe_id = sasami_kunsei.id
end

# レシピ2データ
torihamu = Recipe.find_or_create_by!(title: "簡単鶏ハムサラダ") do |recipe|
  recipe.recipe_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/recipe2.jpg"), filename: "recipe2.jpg")
  recipe.material = %Q{鶏胸肉(300〜400g)\n砂糖(小さじ1)\n粗塩(小さじ1)\nオリーブオイル(小さじ1)\nお好みの野菜}
  recipe.process = %Q{1.鶏胸肉を縦半分に切り、砂糖→塩の順ですり込み、耐熱皿に並べてオリーブオイルをかけ10分ほど置きます。\n
  2.1にラップをかけてレンジ600Wで5分、裏返して2分加熱し、冷めるまでラップをかけたまま放置して鶏ハムの完成です。\n
  3.冷めたら食べやすい大きさにカットし、お好みの野菜と一緒にさらに盛り付けて完成です。}
  recipe.user = taro
  recipe.tags << torimuneniku_tag
  recipe.tags << genryou_tag
  recipe.tags << sarada_tag
  recipe.tags << torihamu_tag
end


