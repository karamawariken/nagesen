json.set! :status, @response
json.set! :flag, @current_user.liked?(@products)
json.set! :errors do
  json.array! @errors do |message|
    json.message message
  end
end
