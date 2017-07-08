json.set! :status, @response
json.set! :errors do
  json.array! @errors do |message|
    json.message message
  end
end
if @product.present?
  json.set! :data do
    json.set! :id, @product.id
    json.set! :username, @product.child.nick_name
    json.set! :introduction, @product.introduction
    #json.set! :user_photoUrl, product.child.user_photoUrl
    json.set! :title, @product.title
    json.set! :image1, @product.image1_link.url
    json.set! :image2, @product.image2_link.url
    json.set! :image3, @product.image3_link.url
  end
end
