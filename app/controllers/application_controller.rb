class ApplicationController < ActionController::Base
    before_action :set_current_user
    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    def require_user_log_in!
        redirect_to sign_in_path, alert: "You must be signed in to do that" if Current.user.nil?
    end

    def admin_user
        redirect_to root_path unless Current.user.is_admin?
    end
end
