class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update]
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
    params.require(:user).permit(:email, :password, :password_confirmation, :time_zone)
  end

  def find_user
    @user = User.find(params[:id])
 end
end
