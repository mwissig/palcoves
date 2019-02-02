class PagesController < ApplicationController
  def home
    @posts = Post.all.where("created_at > ?", Time.now - 2419200).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
    if logged_in?
      @tags = []
      @tagged_posts = []
      @current_user.usernames.each do |us|
        Follow.all.where(username_id: us.id).each do |fol|
          @tags.push(fol)
        end
      end
      @tags.uniq!
      @tags.each do |tag|
        if tag.recipient_id == nil
          post_by_tags = Post.pluck(:tags)
          matches = []
          post_by_tags.each do |t|
            if t != nil
              matches << t if t.downcase.include?(tag.tag)
            end
          end
          matches.each do |match|
            matched_posts = Post.where(tags: match)
            matched_posts.each do |post|
              @tagged_posts << post
            end
          end
      else
        @followed_accts = Post.all.where(username_id: tag.recipient_id)
        @followed_accts.each do |post|
        @tagged_posts << post
        end
      end

    end
        @posts = Post.all.where(id: @tagged_posts.map(&:id)).distinct.where("created_at > ?", Time.now - 2419200).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
  else
        @posts = Post.all.where("created_at > ?", Time.now - 2419200).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
  end
  end

def browse
  @posts = Post.all.where("created_at > ?", Time.now - 2419200).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
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

  def oldposts
    @posts = Post.all.where("created_at <= ?", Time.now - 2419200).where(username_id: @username.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
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

def readnotes
   if logged_in? && @current_user.usernames.present?
     @notifs = []
     @current_user.usernames.each do |us|
       if Notification.find_by(username_id: us.id) != nil
    @notifs << Notification.find_by(username_id: us.id)
  end
  end
  @my_notifs = Notification.all.where(id: @notifs.map(&:id))
    @notifications = @my_notifs.where(read: true).order("created_at DESC").paginate(:page => params[:page], :per_page => 50)
  end
end



def followtag
@follow = Follow.new
end

  def search; end
end
