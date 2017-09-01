module API
  module V1
    class Users < Grape::API
      resource :users do

        #ユーザ新規作成
        # POST /api/v1/users/sign_up
        desc 'Return create sucess or failure'
        params do
        end
        post '/sign_up', jbuilder: 'api/v1/users/sign_up' do
          @params ||= JSON.parse(request.body.read, {:symbolize_names => true})
          user = User.find_by_email(@params['email'])
          if user.present?
            api_error!('This email already registered.', "failure", 406,'')
          else
            uid = User.create_unique_string
            @user = User.create(uid: uid,
                                provider: 'email',
                                email:  @params['email'],
                                username:  @params['username'],
                                password: @params['password'])
            @response = "success"
            @user.generate_access_token if @user.access_token.blank?
            @user.save!
          end

        end

        #ユーザ家族情報
        # GET /api/v1/users/mypage
        desc 'Return current userdata'
        params do
        end
        get '/mypage', jbuilder: 'api/v1/users/mypage' do
          authenticate_user!
          @response = "success"
        end

        #ユーザのお子さん情報
        # GET /api/v1/users/mykids
        desc 'Return current user_kids_data'
        params do
        end
        get '/mykids', jbuilder: 'api/v1/users/mykids' do
          authenticate_user!
          @response = "success"
        end

        #一般ユーザがお子さんをフォロー
        # POST /api/v1/users/follow
        desc 'Return follower success or failure'
        params do
        end
        post '/follow', jbuilder: 'api/v1/users/follow' do
          authenticate_user!
          @params ||= JSON.parse(request.body.read, {:symbolize_names => true})
          @kids = Kid.find(@params['kid_id'])
          if @kids.present?
            if @current_user.following?(@kids)
              @current_user.stop_following(@kids)
            else
              @current_user.follow(@kids)
            end
            @response = "success"
          else
            api_error!('Kids not found.', "failure", 406,'')
          end

        end

      end
    end
  end
end
