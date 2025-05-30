class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
      
        alias_method :current_user, :current_api_v1_user
end
      