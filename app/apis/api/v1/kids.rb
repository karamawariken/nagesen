module API
  module V1
    class Kids < Grape::API
      resource :kids do

        #お子さん新規作成
        # POST /api/v1/kids/create
        desc 'Return create sucess or failure'
        params do
        end
        post '/create', jbuilder: 'api/v1/kids/create' do
          authenticate_user!
          params ||= JSON.parse(request.body.read, {:symbolize_names => true})
          birthday = Date.strptime(params[:birthday],'%Y年%m月%d日')
          date_format = "%Y%m%d"
          (Date.today.strftime(date_format).to_i - birthday.to_i) / 10000

          if @current_user.present?
            @kid = @current_user.kids.build(
                :nick_name => params[:nick_name],
                :introduction => params[:introduction],
                :sex => params[:sex],
                :birthday => birthday
            )
            @kid.save!
            @response = "success"
          else
            @response = "failure"
            api_error!('This email already registered.', "failure", 406,'')
          end

        end

        #ユーザ家族情報
        # GET /api/v1/users/mypage
        desc 'Return current userdata'
        params do
        end
        get '/mypage', jbuilder: 'api/v1/users/mypage' do
          authenticate_user!
        end

      end
    end
  end
end
