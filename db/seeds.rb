# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
2.times do |i|
  user = User.create(uid: User.create_unique_string,
                      provider: "email",
                      email: "miaca#{i}@gmail.com",
                      username: "miaca#{i}",
                      password: 'miaca1234',
                      avatar: open("#{Rails.root}/db/test_data/avatar/avatar#{i}.jpg"),
                      address: 16
                      )
  user.generate_access_token if user.access_token.blank?
  user.save!
  birthday = Date.new(1988, 6, 11)
  kid = user.kids.build(
      :nick_name => "kid#{i}",
      :introduction => "テストお子さん#{i}さんですよ〜",
      :sex => "female",
      :birthday => birthday,
      :avatar => open("#{Rails.root}/db/test_data/avatar/avatar#{i+2}.jpg")
  )
  kid.save!
end


1.step(9, 3) do |i|
  current_kid = Kid.find(1)
  product = current_kid.products.build(
    :title => "テスト作品#{i}",
    :introduction => "テスト作品#{i}の説明",
    :introduction_voice_link => "test",
    :image1_link => open("#{Rails.root}/db/test_data/product/product#{i}.jpg"),
    :image2_link => open("#{Rails.root}/db/test_data/product/product#{i+1}.jpg"),
    :image3_link => open("#{Rails.root}/db/test_data/product/product#{i+2}.jpg"),
    :state => "public",
    )
  product.save
end

10.step(15, 3) do |i|
  current_kid = Kid.find(2)
  product = current_kid.products.build(
    :title => "テスト作品#{i}",
    :introduction => "テスト作品#{i}の説明",
    :introduction_voice_link => "test",
    :image1_link => open("#{Rails.root}/db/test_data/product/product#{i}.jpg"),
    :image2_link => open("#{Rails.root}/db/test_data/product/product#{i+1}.jpg"),
    :image3_link => open("#{Rails.root}/db/test_data/product/product#{i+2}.jpg"),
    :state => "public",
    )
  product.save
end
