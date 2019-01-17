class FollowsController < ApplicationController
  before_action :find_follow, only: %i[show edit update]
  before_action :find_username, only: %i[create new show edit update]
  before_action :find_user, only: %i[create new show edit update]
  def new
    if logged_in?
    @user = @current_user
    @follow = Follow.new
  end

    end

  def create
    if logged_in?
    @follow = Follow.new(follow_params)
    @user = @current_user
     @follow.save!
    if @follow.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: username_follow_path(@follow.username, @follow))
      msg = @follow.errors.full_messages
      flash.now[:error] = msg
    end
  end
end

  def edit; end

  def update
    if @follow.update(follow_params)
      p 'follow successfully updated'
      redirect_back(fallback_location: root_path)
    else
      msg = @follow.errors.full_messages
flash.now[:error] = msg
      redirect_back(fallback_location: root_path)
    end
end

  def show
    @follow = Follow.find(params[:id])
  end

  def index
    @follows = Follow.all
  end

  def destroy
  @follow = Follow.find(params[:follow_id])
  @follow.destroy
  redirect_to root_path
end

end
  private

  def follow_params
    params.require(:follow).permit(:body, :username_id, :recipient_id, :tag)
  end

  def find_follow
    @follow = Follow.find(params[:id])
 end


    def find_username
      @username = Username.friendly.find(params[:username_id])
   end

   def find_user
     if logged_in?
     @user = @username.user
      end
     end
