class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username:      auth.extra.raw_info.name,
                         provider:  auth.provider,
                         uid:       auth.uid,
                         email:     auth.info.email,
                         password:  Devise.friendly_token[0,20]
                        )
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username:      auth.extra.raw_info.name,
                         provider:  auth.provider,
                         uid:       auth.uid,
                         email:     User.create_unique_email,
                         password:  Devise.friendly_token[0,20]
                        )
    end
    user
  end

  #OAuth認証を使わず通常の登録フォームからユーザー登録でサインインさせる場合、
  #適当な一意のランダムな値をusersテーブルのuidカラムに格納しておく（provider は空にする、default “”）。
  #uidの格納は、通常フォームからのユーザー登録時に行いたいので、サインアップ時に独自に追加する。

  # 通常サインアップ時のuid用、Twitter OAuth認証時のemail用にuuidな文字列を生成
  def self.create_unique_string
    SecureRandom.uuid
  end

  #アプリクライアント側からのアクセストークン作成用
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end
  end

  def valid_token?(token)

# 当面無期限 return false if DateTime.now >= self.expires_at
  return false if token.blank?
  return false if token != self.access_token
  return true
end

  #twitterでは、emailを取得できないので、適当に一位のemailを生成
  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end

end
