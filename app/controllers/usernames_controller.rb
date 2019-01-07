class UsernamesController < ApplicationController

    before_action :find_username, only: %i[show edit update]
    def new
      @user = @current_user
      @username = Username.new
      end

    def create
      if logged_in?
      @username = Username.new(username_params)
      @username.user_id = @current_user.id
      if @username.save
        if @username.default == true && @current_user.usernames.count > 1
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
      @username = Username.find_by username: params[:username]
    end

    def index
      @usernames = Username.all
    end

    def destroy
    @username = Username.find(params[:username_id])
    @username.destroy
    redirect_to root_path
  end

  def set_default
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
      params.require(:username).permit(:username, :profile, :avatar, :default)
    end

    def find_username
      @username = Username.find_by username: params[:username]
   end

end
