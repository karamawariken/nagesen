json.set! :status, @response
json.set! :errors do
  json.array! @errors do |message|
    json.message message
  end
end
json.set! :data do
  json.products(@products) do |product|
    json.set! :id, product.id
    json.set! :kid_id, product.kid.id
    json.set! :username, product.kid.nick_name
    json.set! :kid_avatar, product.kid.avatar.url
    json.set! :title, product.title
    json.set! :image1, product.image1_link.url
    json.set! :image2, product.image2_link.url
    json.set! :image3, product.image3_link.url
    json.set! :follow_flag, @current_user.following?(product.kid)
    json.set! :like_flag, @current_user.liked?(product)
    puts "product:#{product.id} #{@current_user.following?(product.kid)} #{@current_user.liked?(product)}"
  end
end
