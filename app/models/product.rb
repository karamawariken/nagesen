class Product < ActiveRecord::Base
  belongs_to :child
  validates :title, length: { maximum: 140}
end
