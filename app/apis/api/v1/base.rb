module API
  module V1
    class Base < Grape::API
      # http://localhost:3000/api/v1/
      format :json
      default_format :json

      # for Grape::Jbuilder
      formatter :json, Grape::Formatter::Jbuilder

      prefix :api #/apiというパスになる
      version 'v1', using: :path #/api/v1というバスになす

      helpers do
        def logger
          Base.logger
        end
        def authenticate_error!
          # 認証が失敗したときのエラー
          h = {'Access-Control-Allow-Origin' => "*",
               'Access-Control-Request-Method' => %w{GET POST OPTIONS}.join(",")}
              api_error!("You need to log in to use the app.", "failure", 401, h)
        end

        def authenticate_user!
          uid = request.headers['Uid']
          token = request.headers['Access-Token']
          @current_user = User.find_by_uid(uid)
          unless @current_user && @current_user.valid_token?(token)
            authenticate_error!
          end
        end

        def api_error!(message, error_code, status, header)
          error!({message: message, code: error_code}, status, header)
        end
      end
      mount V1::Products
      mount V1::Auth
      mount V1::Users
    end
  end
end
