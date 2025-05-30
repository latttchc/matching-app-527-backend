class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken

        alias_method :current_user, :current_api_v1_user

        before_action :set_cors_headers

        private

        def set_cors_headers
            response.headers["Access-Control-Allow-Credentials"] = "true"
        end
end
