class PagesController < ApplicationController
  def home
    @posts = Post.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
  end
  def post
    if logged_in?
    @post = Post.new
    @user = @current_user
    @username = @user.usernames.find_by(default: true)

      names = ["(Default) " + @current_user.usernames.find_by(default: true).name]
      ids = [@current_user.usernames.find_by(default: true).id]
        @current_user.usernames.each do |u|
          names.push u.name
        end
        @current_user.usernames.each do |u|
          ids.push u.id
        end
        @username_selector = names.zip(ids)
  end
  end

  def inbox
    @pms = Pm.all
    if logged_in?
    @notifications = Notification.where("username.user = ?", @current_user)
    @unread_notifs = @notifications.where(read: false)
  end

      def markallread
        if logged_in?
          @current_user.usernames.each do |u|
            u.notifications.where(read: false).each do |note|
              note.read = true
              note.save!
            end
          end
        redirect_back(fallback_location: inbox_path)
      end
  end
end


  def search; end
end
