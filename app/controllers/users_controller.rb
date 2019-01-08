class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update]
  def new
    @user = User.new
    end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'new'
      msg = @user.errors.full_messages
      flash.now[:error] = msg
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      p 'user successfully updated'
      redirect_back(fallback_location: root_path)
    else
      msg = @user.errors.full_messages
flash.now[:error] = msg
      redirect_back(fallback_location: root_path)
    end
end

  def show
    @user = User.find(params[:id])

  end

  def index
    @users = User.all
  end

  def destroy
  @user = User.find(params[:user_id])
  @user.destroy
  redirect_to register_path
end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
 end
end
