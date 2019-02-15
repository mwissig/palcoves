class UsernamesController < ApplicationController

    before_action :find_username, only: %i[show edit update archive gallery]
    def new
      @user = @current_user
      @username = Username.new
      end
      def archive
        @posts = Post.where(username_id: @username, archive: true).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
       end
      def gallery
        @posts = Post.where(username_id: @username, gallery: true).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
       end

    def create
      if logged_in?
      @username = Username.new(username_params)
      @username.user_id = @current_user.id
      if @username.save(username_params)
        Userstyle.create(
            username_id: @username.id,
            post_background_color: '#ffffff',
            page_background_color: '#ffffff',
            post_text_color: '#000000',
            signature: '',
            signature_css: ''
        )
        if @username.default == true || @current_user.usernames.count == 1
          set_default
        end
        redirect_to user_path(@current_user)
      else
        render 'new'
        msg = @username.errors.full_messages
        flash.now[:error] = msg
      end
    end
  end

    def edit; end

    def update
      if @username.update(username_params)
        if logged_in?
        if @username.default == true && @current_user.usernames.count > 1
          set_default
        end
      end
        p 'username successfully updated'
        redirect_back(fallback_location: root_path)
      else
        msg = @username.errors.full_messages
  flash.now[:error] = msg
        redirect_back(fallback_location: root_path)
      end
  end

    def show
      @username = Username.friendly.find(params[:id])
      @posts = Post.all.where("created_at > ?", Time.now - 2419200).where(username_id: @username.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
      @archiveprev = @username.posts.order("created_at DESC").where(archive: true).limit(6)
      @galleryprev =  @username.posts.order("created_at DESC").where(gallery: true).limit(6)
    end

    def old
      @username = Username.friendly.find(params[:id])
      @posts = Post.all.where("created_at < ?", Time.now - 2419200).where(username_id: @username.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
    end

    def index
      @usernames = Username.all
    end

    def destroy
    @username = Username.friendly.find(params[:id])
    @username.destroy
        redirect_to user_path(@current_user)
  end

  def merge
    @username_to_save = Username.friendly.find(params[:username_id])
    @username_to_delete = Username.find(params[:delete_id])
  end

  def confirm_merge
    if logged_in?
    @username_to_save = Username.friendly.find(params[:username_id])
    @username_to_delete = Username.friendly.find(params[:delete_id])
    if @username_to_save.user == @current_user && @username_to_delete.user == @current_user
    @username_to_delete.comments.each do |comment|
      comment.username_id = @username_to_save.id
      comment.save!
    end
    @username_to_delete.follows.each do |follow|
      follow.username_id = @username_to_save.id
      @follow.save!
    end
    Follow.all.where(recipient_id: @username_to_delete.id).each do |follow|
      follow.recipient_id = @username_to_save.id
      follow.save!
    end
    @username_to_delete.pms.each do |pm|
      pm.username_id = @username_to_save.id
      pm.save!
    end
    Pm.all.where(recipient_id: @username_to_delete.id).each do |pm|
      pm.recipient_id = @username_to_save.id
      pm.save!
    end
    @username_to_delete.notifications.each do |notification|
      notification.username_id = @username_to_save.id
      notification.save!
    end
    Notification.all.where(sender_id: @username_to_delete.id).each do |note|
      note.sender_id = @username_to_save.id
      note.save!
    end
    @username_to_delete.posts.each do |post|
      post.username_id = @username_to_save.id
      post.save!
    end
    if @username_to_delete.default == true
      @username_to_save.default = true
      @username_to_save.save!
    end
    @username_to_delete.userstyle.destroy
    @username_to_delete.destroy
    if logged_in?
    redirect_to user_path(@current_user)
  else
    redirect_to root_path
  end
else
      redirect_to root_path
end
end
end

  def set_default
    @username ||= Username.friendly.find(params[:id])
    @current_user.usernames.each do |u|
      if u == @username
        u.default = true
      else
      u.default = false
    end
      u.save!
    end
  end

    private

    def username_params
      params.require(:username).permit(:id, :slug, :name, :profile, :avatar, :default)
    end

    def find_username
      @username = Username.friendly.find(params[:id])
   end

end
