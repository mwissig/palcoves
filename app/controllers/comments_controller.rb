class CommentsController < ApplicationController
  before_action :find_comment, only: %i[show edit update]
  before_action :find_post, only: %i[create new show edit update]
  before_action :find_username, only: %i[create new show edit update]
  before_action :find_user, only: %i[create new show edit update]
  def new
    if logged_in?
      @user = @current_user
      @comment = Comment.new
  end
    end

  def create
    if logged_in?
      @comment = Comment.new(comment_params)
      @user = @current_user
      @comment.save!
      if @comment.save
        if @comment.shared == true
          Post.create(
            username_id: @comment.username_id,
            title: @comment.post.title,
            body: @comment.post.body,
            share_comment: @comment.body,
            op_id: @comment.post.id,
            archive: false,
            gallery: false
          )
  end
        redirect_back(fallback_location: root_path)
      else
        render 'new'
        msg = @comment.errors.full_messages
        flash.now[:error] = msg
      end
  end
end

  def edit; end

  def update
    if @comment.update(comment_params)
      if logged_in?
    end
      p 'comment successfully updated'
      redirect_back(fallback_location: root_path)
    else
      msg = @comment.errors.full_messages
      flash.now[:error] = msg
      redirect_back(fallback_location: root_path)
    end
end

  def show
    @comment = Comment.find(params[:id])
  end

  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to root_path
end

    private

  def comment_params
    params.require(:comment).permit(:username_id, :body, :reply_id, :post_id, :shared, :private, :recipient_id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
 end

  def find_post
    @post = Post.find(params[:post_id])
 end

  def find_username
    @username = Username.friendly.find(params[:username_id])
 end

  def find_user
    @user = @username.user if logged_in?
    end
  end
