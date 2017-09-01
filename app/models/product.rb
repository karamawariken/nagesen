class Product < ActiveRecord::Base
  belongs_to :kid
  validates :title, length: { maximum: 140}


  #作品の画像アップロードにuploaders/image_uploaderを使う
  mount_uploader :image1_link, ImageUploader
  mount_uploader :image2_link, ImageUploader
  mount_uploader :image3_link, ImageUploader

  #Userからフォローされる
  acts_as_votable

  def self.find_public_products
    products = Product.where(:state => "public")
  end

  def self.find_draft_products
    #ここに親子のid入れる
    products = Product.where(:state => "draft")
  end
end
