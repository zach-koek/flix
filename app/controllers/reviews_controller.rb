class ReviewsController < ApplicationController

    before_action :set_up

    before_action :require_signin

    def index
        @reviews = @movie.reviews
    end

    def new
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(review_params)
        @review.user = current_user
        if @review.save
            redirect_to movie_reviews_path(@movie), notice: "Review Successfully Submitted!"
        else 
            render :new 
        end
    end



private

    def set_up
        @movie= Movie.find_by!(slug: params[:movie_id])
    end

    def review_params
        params.require(:review).permit(:comment, :stars)
    end
end
