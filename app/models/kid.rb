class Kid < ActiveRecord::Base
  has_many :products
  belongs_to :user

  #フォロー機能(userからフォローされる)
  acts_as_followable

  #アイコン用の画像アップロードにuploaders/avatar_uploaderを使う
  mount_uploader :avatar, AvatarUploader

end
