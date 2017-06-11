class Child < ActiveRecord::Base
  has_many :products
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nick_name, presence: true
end
