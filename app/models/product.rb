class Product < ActiveRecord::Base
  belongs_to :child
  validates :title, length: { maximum: 140}
  mount_uploader :image1_link, ImageUploader
  mount_uploader :image2_link, ImageUploader
  mount_uploader :image3_link, ImageUploader

  def self.find_public_products
    products = Product.where(:state => "public")
  end

  def self.find_draft_products
    #ここに親子のid入れる
    products = Product.where(:state => "draft")
  end
end
