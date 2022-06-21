class NotificationsController < ApplicationController
    before_action :require_user_log_in!
    def index
        @notifications  = Current.user.notifications.order(created_at: :desc)
    end
    def seen
        @notification = Notification.find(params[:id])
        if params[:seen] == nil
            params[:seen] = false
        end
        @notification.update_attribute(:seen, params[:seen])
    end
    def destroy
        notification = Notification.find(params[:id])
        notification.destroy
        redirect_back(fallback_location: root_path,flash: {notice: "Notification deleted"})
    end
end
