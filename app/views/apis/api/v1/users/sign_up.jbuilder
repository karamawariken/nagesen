json.set! :status, @response
json.set! :errors do
  json.array! @errors do |message|
    json.message message
  end
end
if @user.present?
  json.set! :data do
    json.set! :uid, @user.uid
    json.set! :access_token, @user.access_token
  end
end
