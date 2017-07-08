json.set! :status, @response
if @user.present?
  json.set! :data do
    json.set! :id, @user.id
    json.set! :provider, @user.provider
    json.set! :uid, @user.uid
    json.set! :username, @user.username
    json.set! :email, @user.email
    json.set! :access_token, @user.access_token
    # json.set! :relation, @user.followed_by?(@current_user)
    #   json.liked_menus(@liked_menus) do |menu|
    #     json.set! :id, menu.id
    #     json.set! :name, menu.name
    #     json.set! :photoUrl, menu.photos.first.image.url(:medium) if menu.photos.present?
    #   end
  end
end
json.set! :errors do
  json.array! @errors do |message|
    json.message message
  end
end
