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

saki = User.find_or_create_by!(email: "saki@example.com") do |user|
  user.name = "saki"
  user.password = "password6"
  user.introduction = %Q{こんにちは！トレーニング初心者です。\nモチベーションを維持したいのでどんどんフォロー・コメントください！}
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/saki.jpg"), filename:"saki.jpg")
end

# フォローテストデータ
taro.follow(hanako.id) if !taro.following?(hanako)
taro.follow(takashi.id) if !taro.following?(takashi)
taro.follow(kanako.id) if !taro.following?(kanako)
taro.follow(kento.id) if !taro.following?(kento)
taro.follow(saki.id) if !taro.following?(saki)

hanako.follow(taro.id) if !hanako.following?(taro)
hanako.follow(takashi.id) if !hanako.following?(takashi)
hanako.follow(kanako.id) if !hanako.following?(kanako)
hanako.follow(kento.id) if !hanako.following?(kento)
hanako.follow(saki.id) if !hanako.following?(saki)

takashi.follow(taro.id) if !takashi.following?(taro)
takashi.follow(hanako.id) if !takashi.following?(hanako)
takashi.follow(kanako.id) if !takashi.following?(kanako)
takashi.follow(kento.id) if !takashi.following?(kento)
takashi.follow(saki.id) if !takashi.following?(saki)

kanako.follow(taro.id) if !kanako.following?(taro)
kanako.follow(hanako.id) if !kanako.following?(hanako)
kanako.follow(takashi.id) if !kanako.following?(takashi)
kanako.follow(kento.id) if !kanako.following?(kento)
kanako.follow(saki.id) if !kanako.following?(saki)

kento.follow(taro.id) if !kento.following?(taro)
kento.follow(hanako.id) if !kento.following?(hanako)
kento.follow(takashi.id) if !kento.following?(takashi)
kento.follow(kanako.id) if !kento.following?(kanako)
kento.follow(saki.id) if !kento.following?(saki)

saki.follow(taro.id) if !saki.following?(taro)
saki.follow(hanako.id) if !saki.following?(hanako)
saki.follow(takashi.id) if !saki.following?(takashi)
saki.follow(kanako.id) if !saki.following?(kanako)
saki.follow(kento.id) if !saki.following?(kento)

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

zouryou_tag = Tag.find_or_create_by!(name: "増量") do |tag|
  tag.name = "増量"
end

powerup_tag = Tag.find_or_create_by!(name: "パワーアップ") do |tag|
  tag.name = "パワーアップ"
end

kintore_tag = Tag.find_or_create_by!(name: "筋トレ") do |tag|
  tag.name = "筋トレ"
end

broccoli_tag = Tag.find_or_create_by!(name: "ブロッコリー") do |tag|
  tag.name = "ブロッコリー"
end

diet_tag = Tag.find_or_create_by!(name: "ダイエット") do |tag|
  tag.name = "ダイエット"
end

# レシピテストデータ
# レシピ1テストデータ
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

# レシピ1いいねテストデータ
Favorite.find_or_create_by!(user_id: kento.id) do |favorite|
  favorite.recipe_id = sasami_kunsei.id
end

# レシピ1コメントテストデータ
Comment.find_or_create_by!(comment: "美味しそうですね！") do |comment|
  comment.user_id = hanako.id
  comment.recipe_id = sasami_kunsei.id
end

Comment.find_or_create_by!(comment: "参考にさせていただきます。") do |comment|
  comment.user_id = takashi.id
  comment.recipe_id = sasami_kunsei.id
end

# レシピ2テストデータ
torihamu = Recipe.find_or_create_by!(title: "簡単鶏ハムサラダ") do |recipe|
  recipe.recipe_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/recipe2.jpg"), filename: "recipe2.jpg")
  recipe.material = %Q{鶏胸肉(300〜400g)\n砂糖(小さじ1)\n粗塩(小さじ1)\nオリーブオイル(小さじ1)\nお好みの野菜}
  recipe.process = %Q{1.鶏胸肉を縦半分に切り、砂糖→塩の順ですり込み、耐熱皿に並べてオリーブオイルをかけ10分ほど置きます。\n
  2.1にラップをかけてレンジ600Wで5分、裏返して2分加熱し、冷めるまでラップをかけたまま放置して鶏ハムの完成です。\n
  3.冷めたら食べやすい大きさにカットし、お好みの野菜と一緒にお皿に盛り付けて完成です。}
  recipe.user = hanako
  recipe.tags << torimuneniku_tag
  recipe.tags << genryou_tag
  recipe.tags << sarada_tag
  recipe.tags << torihamu_tag
end

# レシピ2いいねテストデータ
Favorite.find_or_create_by!(user_id: taro.id) do |favorite|
  favorite.recipe_id = torihamu.id
end

Favorite.find_or_create_by!(user_id: hanako.id) do |favorite|
  favorite.recipe_id = torihamu.id
end

Favorite.find_or_create_by!(user_id: kanako.id) do |favorite|
  favorite.recipe_id = torihamu.id
end

# レシピ2コメントテストデータ
Comment.find_or_create_by!(comment: "いつも投稿楽しみにしてます！") do |comment|
  comment.user_id = saki.id
  comment.recipe_id = torihamu.id
end

Comment.find_or_create_by!(comment: "ありがとうございます！これからも投稿頑張ります！") do |comment|
  comment.user_id = hanako.id
  comment.recipe_id = torihamu.id
end

# レシピ3テストデータ
chicken_nanban = Recipe.find_or_create_by!(title: "チキン南蛮") do |recipe|
  recipe.recipe_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/recipe3.jpg"), filename: "recipe3.jpg")
  recipe.material = %Q{鶏胸肉(200g)\n小麦粉(適量)\n溶き卵(1個分)\nオリーブオイル(適量)\nお好みの野菜\n<甘酢タレ>\n醤油(大さじ2)\n酢(大さじ2)\n砂糖(大さじ2)\n＊タルタルソースは市販のものを使いました}
  recipe.process = %Q{1.甘酢タレの材料を混ぜ合わせておく。\n
  2.鶏胸肉は1口台の大きさに切り、塩少々(分量外)と小麦粉をまぶし、溶き卵をつける。\n
  3.フライパンにオリーブオイルを入れ、鶏胸肉を揚げ焼きする。\n
  4.火を止め、余分な油を拭き取り、1を入れて全体に絡ませる。\n
  5.お好みの野菜と一緒にお皿に盛り付けタルタルソースをかけて完成。}
  recipe.user = kanako
  recipe.tags << torimuneniku_tag
  recipe.tags << zouryou_tag
  recipe.tags << powerup_tag
  recipe.tags << kintore_tag
end

# レシピ3いいねテストデータ
Favorite.find_or_create_by!(user_id: takashi.id) do |favorite|
  favorite.recipe_id = chicken_nanban.id
end

Favorite.find_or_create_by!(user_id: saki.id) do |favorite|
  favorite.recipe_id = chicken_nanban.id
end

# レシピ3コメントテストデータ
Comment.find_or_create_by!(comment: "オリーブオイルは結構入れますか？") do |comment|
  comment.user_id = hanako.id
  comment.recipe_id = chicken_nanban.id
end

Comment.find_or_create_by!(comment: "揚げ焼きなのでフライパンの底から1cmくらいを目安にしてください！") do |comment|
  comment.user_id = kanako.id
  comment.recipe_id = chicken_nanban.id
end

Comment.find_or_create_by!(comment: "ありがとうございます！") do |comment|
  comment.user_id = hanako.id
  comment.recipe_id = chicken_nanban.id
end

# レシピ4テストデータ
umeshiso = Recipe.find_or_create_by!(title: "ささみの梅しそ串焼き") do |recipe|
  recipe.recipe_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/recipe4.jpg"), filename: "recipe4.jpg")
  recipe.material = %Q{ささみ(2本)\n大葉(1枚)\n塩(少々)\nサラダ油(適量)\n梅肉(適量)\n串(2本)}
  recipe.process = %Q{1.ささみの筋に沿って切り込みを入れ、筋を取る。\n
  2.ささみを串に刺していく。(大きければお好みのサイズに切ってください！)\n
  3.串に刺したささみの面裏に塩を軽く振る。\n
  4.フライパンに油を引き、中火で面裏を焼く。\n
  5.火が通ったら、お皿に乗せ、梅肉をかけ、刻んだ大葉をかけて完成！}
  recipe.user = taro
  recipe.tags << sasami_tag
end

# レシピ4コメントテストデータ
Comment.find_or_create_by!(comment: "フォローしました！！") do |comment|
  comment.user_id = kento.id
  comment.recipe_id = umeshiso.id
end

# レシピ5テストデータ
broccoli = Recipe.find_or_create_by!(title: "茹でブロッコリー") do |recipe|
  recipe.recipe_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/recipe5.jpg"), filename: "recipe5.jpg")
  recipe.material = %Q{ブロッコリー(1株)\nお湯(1l)\n塩(小さじ1)}
  recipe.process = %Q{1.ブロッコリーをよく洗い、茎と房を分ける。\n
  2.房を１口大の大きさに切り分け、茎は硬い皮の部分を剥き、乱切りにする。\n
  3.鍋にお湯を沸かして塩を入れ、切った茎を入れて30秒茹でる。\n
  4.小房を加え、再沸騰したら火を止める。\n
  5.ザルにあげて様したら完成。}
  recipe.user = taro
  recipe.tags << diet_tag
  recipe.tags << broccoli_tag
end

# レシピ6テストデータ
broccoli = Recipe.find_or_create_by!(title: "鶏胸肉のヘルシーポン酢煮") do |recipe|
  recipe.recipe_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/recipe6.jpg"), filename: "recipe6.jpg")
  recipe.material = %Q{鶏胸肉(1枚)\nポン酢(50cc)\n料理酒(25cc)\n水2(5cc)\n生姜チューブ(3cm)\n卵(1個)}
  recipe.process = %Q{1.胸肉を爪楊枝で刺し、味がしみやすいようにする。\n
  2.圧力鍋に材料を全て入れ、20分煮る。\n
  3.圧力鍋のピンが下がったら、お皿に写して完成。}
  recipe.user = kento
  recipe.tags << diet_tag
  recipe.tags << torimuneniku_tag
end