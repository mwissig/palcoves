class UsernamenamesController < ApplicationController

    before_action :find_username, only: %i[show edit update]
    def new
      @username = Username.new
      end

    def create
      @username = Username.new(username_params)
      if @username.save
        redirect_to user_path(@current_user)
      else
        render 'new'
        msg = @username.errors.full_messages
        flash.now[:error] = msg
      end
    end

    def edit; end

    def update
      if @username.update(username_params)
        p 'username successfully updated'
        redirect_back(fallback_location: root_path)
      else
        msg = @username.errors.full_messages
  flash.now[:error] = msg
        redirect_back(fallback_location: root_path)
      end
  end

    def show
      @username = Username.find(params[:id])
    end

    def index
      @usernames = Username.all
    end

    def destroy
    @username = Username.find(params[:username_id])
    @username.destroy
    redirect_to root_path
  end

    private

    def username_params
      params.require(:username).permit(:username, :description, :default)
    end

    def find_username
      @username = Username.find(params[:id])
   end

end
