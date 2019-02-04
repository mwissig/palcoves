class PmsController < ApplicationController
  def index
        @username = Username.friendly.find(params[:username_id])
    @pms_to_me = Pm.where(recipient_id: @username.id)
  end

  def show
            @username = Username.friendly.find(params[:username_id])
            @sender = Username.friendly.find(params[:id])
            @msgs = []
            Pm.where(username_id: @username.id).each do |pm|
              @msgs << pm
            end
            Pm.where(recipient_id: @username.id).each do |pm|
              @msgs << pm
            end
            @messages = Pm.all.where(id: @msgs.map(&:id))
            @conversation = @messages.order("created_at DESC").paginate(:page => params[:page], :per_page => 50)
  end
end
