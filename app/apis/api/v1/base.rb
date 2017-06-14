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

      mount V1::Products
    end
  end
end
