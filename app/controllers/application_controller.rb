class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_raven_context
          @comment = Comment.new



          def search; end

          def results
            @follow = Follow.new

            if @current_user != nil
                          @username = @current_user.usernames.find_by(default: true).name
            names = ["(Default) " + @current_user.usernames.find_by(default: true).name]
            ids = [@current_user.usernames.find_by(default: true).id]
              @current_user.usernames.each do |u|
                names.push u.name
              end
              @current_user.usernames.each do |u|
                ids.push u.id
              end
              @username_selector = names.zip(ids)
            end
            @searchtype = params[:t]
            @results = params[:q]
            query = params[:q].downcase
            matches = []
            @final_results = []


            if @searchtype == "People"

              usernames_by_name = Username.pluck(:name)
              usernames_by_profile = Username.pluck(:profile)
              matches = []
              @final_results = []
              usernames_by_name.each do |u|
                if u != nil
                matches << u if u.downcase.include?(query)
                end
              end
              usernames_by_profile.each do |u|
                if u != nil
                matches << u if u.downcase.include?(query)
                end
              end

              matches.each do |match|
                x = Username.where(name: match)
                z = Username.where(profile: match)
                x.each do |y|
                  @final_results << y
                end
                z.each do |y|
                  @final_results << y
                end
              end

                @final_results.uniq!

                @usernames = Username.where(id: @final_results.map(&:id)).distinct.order("name DESC").paginate(:page => params[:page], :per_page => 20)

              end



             if @searchtype == "Tags"
            post_by_tags = Post.pluck(:tags)
              post_by_tags.each do |t|
                if t != nil
                matches << t if t.downcase == query
              end
              end

              matches.each do |match|
                x = Post.where(tags: match)
                x.each do |y|
                  @final_results << y
                end


            @final_results.uniq!
            @posts = Post.all.where(id: @final_results.map(&:id)).distinct.order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
          end



  end


              def followtag
                Follow.create(
                  username_id: params[:username_id],
                  tag: @results,
                  )
                  redirect_back(fallback_location: search_path)
              end
        end


          private

          def set_raven_context
            Raven.user_context(id: session[:current_user_id]) # or anything else in session
            Raven.extra_context(params: params.to_unsafe_h, url: request.url)
          end

end
