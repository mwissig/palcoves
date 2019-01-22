class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_raven_context
          @comment = Comment.new



          def search; end

          def results
            @follow = Follow.new

            if @current_user != nil
                          @usernmae = @current_user.usernames.find_by(default: true).name
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

            @results = params[:q]
            query = params[:q].downcase
            post_by_tags = Post.pluck(:tags)
            matches = []
            @final_results = []

              post_by_tags.each do |t|
                if t != nil
                matches << t if t.downcase.include?(query)
              end
              end

              matches.each do |match|
                x = Post.where(tags: match)
                x.each do |y|
                  @final_results << y
                end


            @final_results.uniq!
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
