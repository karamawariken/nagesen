json.set! :status, @response
json.set! :errors do
  json.array! @errors do |message|
    json.message message
  end
end
