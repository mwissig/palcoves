class PmsController < ApplicationController
  def index
        @username = Username.friendly.find(params[:username_id])
    @pms_to_me = Pm.where(recipient_id: @username.id)
  end

  def show
      @pm = Pm.new
            @username = Username.friendly.find(params[:username_id])
            @sender = Username.friendly.find(params[:id])
            @msgs = []
            Pm.where(username_id: @username.id, recipient_id: @sender.id).each do |pm|
              @msgs << pm
            end
            Pm.where(recipient_id: @username.id, username_id: @sender.id).each do |pm|
              @msgs << pm
            end
            @messages = Pm.all.where(id: @msgs.map(&:id))
            @conversation = @messages.order("created_at ASC").paginate(:page => params[:page], :per_page => 50)
end

def create
  if logged_in?
    @pm = Pm.new(pm_params)
    @pm.save!
    if @pm.save
          Notification.create(
            kind: 'private_message',
            username_id: @pm.recipient_id,
            sender_id: @pm.username_id,
            body: @pm.body,
            read: false
          )
    end
    redirect_back(fallback_location: root_path)
    else
      render 'new'
      msg = @pm.errors.full_messages
      flash.now[:error] = msg
    end
end

private

def pm_params
params.require(:pm).permit(:username_id, :body, :recipient_id)
end
end
