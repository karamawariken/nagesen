json.set! :status, @response
json.set! :errors do
  json.array! @errors do |message|
    json.message message
  end
end
if @current_user.kids.present?
  json.set! :kids_data do
    json.kids(@current_user.kids) do |kid|
      json.set! :id, kid.id
      json.set! :nick_name, kid.nick_name
    end
  end
end
