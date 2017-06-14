module API
  class Base < Grape::API
    error_formatter :json, API::ErrorFormatter
    mount V1::Base
  end
end
