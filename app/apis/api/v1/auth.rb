module API
  module V1
    class Auth < Grape::API
      resource :auth do

        #サインイン処理
        #FBやTwitterでユーザが存在しなかったら作成

        # POST /api/v1/auth/sign_in
        desc "sign in"
        params do
          optional :email, type: String, desc: "Email address"
          optional :password, type: String, desc: "Password"
        end
        post '/sign_in', jbuilder: 'api/v1/auth/show' do
          device_token = request.headers['Device-Token']
          if params[:email].present?
            #email/password認証
            @user = User.find_by_email(params[:email])

            if @user
              if @user.valid_password?(params[:password])
                #@user.provider = 'email'
                #@user.device_token = device_token if device_token.present?
                @user.generate_access_token if @user.access_token.blank?
                #@user.set_expiration
                #@user.save!
                @response = "success"
              else
                api_error!('Wrong Password.', "failure", 401,'')
              end
            else
                api_error!('Email does not exist.', "failure", 404,'')
            end
          else
            #facebook認証
            token = request.headers['Fb-Access-Token']
            if token.present?
              #facobookから情報もってくる
              @graph = Koala::Facebook::API.new(token)
              profile = @graph.get_object("me?fields=name,email,location,picture.type(large)")
              @user = User.find_by_uid(profile['id'])
              unless @user
                @user = User.create(uid: profile['id'],
                                    provider: 'facebook',
                                    email:  profile['email'],
                                    name:  profile['name'],
                                    password: Devise.friendly_token.first(16))
              end
              @user.provider = 'facebook'
              @user.uid = profile['id']
              @user.generate_access_token if @user.access_token.blank?
              @user.save!
              @response = "sccess"
              # @user.facebook_token = token
              # @user.device_token = device_token if device_token.present?
              # @user.set_expiration
              # @user.save!
            else
              @resoponse = "Invalid Facebook Access-Token failure"
            end
          end
          # auth_header = @user.build_auth_header(@user.access_token)
          # headers.merge!(auth_header)
          #header 'Access-Token',  @user.access_token
          #header 'Uid', @user.uid
        end
      end
    end
  end
end
