class ApplicationController < ActionController::Base
    before_action :set_current_user
    before_action :get_unread_notifications
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

    def only_hr
        redirect_to root_path unless Current.user.is_hr?
    end

    def get_unread_notifications
        if Current.user
            @unread_notifications = Current.user.notifications.where({seen: false}).order(created_at: :desc)
            @unread_count = @unread_notifications.count
        end
    end
end
