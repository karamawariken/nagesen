json.array!(@products) do |product|
  json.extract! product, :id, :child_id, :title, :introduction, :introduction_voice_link, :image1_link, :image2_link, :image3_link, :state
  json.url product_url(product, format: :json)
end
