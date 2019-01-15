class UserstylesController < ApplicationController

  before_action :find_userstyle, only: %i[edit update show]
  before_action :find_username, only: %i[edit update show]

  def index
    @userstyles = Userstyle.all
  end

  def new
    @userstyle = Userstyle.new
    end

  def create
    @userstyle = Userstyle.new(userstyle_params)
    if @userstyle.save
      redirect_to login_path
    else
      render 'new'
      msg = @user.errors.full_messages
      flash.now[:error] = msg
    end
  end


  def edit; end

  def update
    if @userstyle.update(userstyle_params)
      p 'user successfully updated'
      redirect_back(fallback_location: root_path)
    else
      msg = @userstyle.errors.full_messages
flash.now[:error] = msg
      redirect_back(fallback_location: root_path)
    end
end

def show
  @userstyle = Userstyle.find(params[:id])
end

  private

  def userstyle_params
    params.require(:userstyle).permit(:post_text_color, :post_background_color, :page_background_color, :signature, :signature_css)
  end

  def find_userstyle
    @userstyle = Userstyle.find(params[:id])
 end

 def find_username
   @username = Username.friendly.find(params[:username_id])
end
end
