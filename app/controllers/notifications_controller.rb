class NotificationsController < ApplicationController

      before_action :find_notification, only: %i[show edit update]
      before_action :find_username, only: %i[create new show edit update]
      before_action :find_user, only: %i[create new show edit update]
      def new
        if logged_in?
        @user = @current_user
        @notification = Notification.new
      end

        end

      def create
        if logged_in?
        @notification = Notification.new(notification_params)
        @user = @current_user
         @notification.save!
        if @notification.save
          redirect_to username_path(@notification.username)
        else
          redirect_back(fallback_location: username_notification_path(@notification.username, @notification))
          msg = @notification.errors.full_messages
          flash.now[:error] = msg
        end
      end
    end

      def edit; end

      def update
        if @notification.update(notification_params)
          if logged_in?
        end
          p 'notification successfully updated'
          redirect_back(fallback_location: root_path)
        else
          msg = @notification.errors.full_messages
    flash.now[:error] = msg
          redirect_back(fallback_location: root_path)
        end
    end

      def show
        @notification = Notification.find(params[:id])
      end

      def index
        @notifications = Notification.all
      end

      def destroy
      @notification = Notification.find(params[:notification_id])
      @notification.destroy
      redirect_to root_path
    end

      private

      def notification_params
        params.require(:notification).permit(:kind, :body, :username_id, :sender_id, :post_id, :comment_id, :read)
      end

      def find_notification
        @notification = Notification.find(params[:id])
     end


        def find_username
          @username = Username.friendly.find(params[:username_id])
       end

       def find_user
         if logged_in?
         @user = @username.user
          end
         end
end
