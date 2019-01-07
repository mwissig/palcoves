class PostsController < ApplicationController

    before_action :find_post, only: %i[show edit update]
    before_action :find_username, only: %i[create new show edit update]
    before_action :find_user, only: %i[create new show edit update]
    def new
      if logged_in?
      @user = @current_user
      @username = @user.usernames.find_by(default: true)
      @post = Post.new
    end
      end

    def create
      if logged_in?
      @post = Post.new(post_params)
      @user = @current_user
      @username = @user.usernames.find_by(default: true)
      @post.username_id = @username.id
      if @post.op_id == "" || @post.op_id == nil
        @post.op_id = @post.id
      end
      @post.username = @current_user.usernames.find_by(default: true)
       @post.save!
      if @post.save
        redirect_to user_path(@current_user)
      else
        render 'new'
        msg = @post.errors.full_messages
        flash.now[:error] = msg
      end
    end
  end

    def edit; end

    def update
      if @post.update(post_params)
        if logged_in?
      end
        p 'post successfully updated'
        redirect_back(fallback_location: root_path)
      else
        msg = @post.errors.full_messages
  flash.now[:error] = msg
        redirect_back(fallback_location: root_path)
      end
  end

    def show
      @post = Post.find(params[:id])
    end

    def index
      @posts = Post.all
    end

    def destroy
    @post = Post.find(params[:post_id])
    @post.destroy
    redirect_to root_path
  end

    private

    def post_params
      params.require(:post).permit(:title, :body, :op_id, :share_comment, :archive, :gallery, :image)
    end

    def find_post
      @post = Post.find(params[:id])
   end


      def find_username
      @username = Username.find(params[:username_id])
     end

     def find_user
       if logged_in?
       @user = @username.user
        end
       end
end
