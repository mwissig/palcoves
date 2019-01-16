class ApplicationController < ActionController::Base
  include SessionsHelper
          @comment = Comment.new

          def search; end

          def results
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
        end
end
