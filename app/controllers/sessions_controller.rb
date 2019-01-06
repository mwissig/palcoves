class SessionsController < ApplicationController
  def new
  end
# authentication: you are who you say you are
#authorization: what privileges does this person have
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path
    else
      msg = "invalid credentials"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    log_out if logged_in?
    redirect_to root_path
    p 'logged out successfully'
  end

end
