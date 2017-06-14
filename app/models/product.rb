class Product < ActiveRecord::Base
  belongs_to :child
  validates :title, length: { maximum: 140}
  mount_uploader :image1_link, ImageUploader
  mount_uploader :image2_link, ImageUploader
  mount_uploader :image3_link, ImageUploader
end
