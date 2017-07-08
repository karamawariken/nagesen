module API
  module V1
    class Users < Grape::API
      resource :users do

        #ユーザ作成
        # POST /api/v1/users/sign_up
        desc 'Return create sucess or failure'
        params do
        end
        post '/', jbuilder: 'api/v1/users/sign_up' do
        #  @params ||= JSON.parse(request.body.read, {:symbolize_names => true})
          #puts @params[:targetImage]
        end

      end
    end
  end
end
