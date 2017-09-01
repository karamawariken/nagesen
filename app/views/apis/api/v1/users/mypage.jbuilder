json.set! :status, @response
json.set! :errors do
  json.array! @errors do |message|
    json.message message
  end
end
if @current_user.present?
  json.set! :data do
    json.set! :username, @current_user.username
    json.set! :user_avatar, @current_user.avatar.url
    #json.set! :adress, @current_user.adress
  end
end
if @current_user.kids.present?
  json.set! :kids_data do
    json.kids(@current_user.kids) do |kid|
      json.set! :id, kid.id
      json.set! :nick_name, kid.nick_name
      json.set! :sex, kid.sex
      json.set! :age, kid.age
      json.set! :introduction, kid.introduction
      json.set! :kid_avatar, kid.avatar.url
      json.set! :products_count, kid.products.count
      json.set! :follower_count, kid.followers.count
    end
  end
end
