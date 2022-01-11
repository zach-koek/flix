class ReviewsController < ApplicationController

    before_action :set_up

    def index
        @reviews = @movie.reviews
    end

    def new
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(review_params)

        if @review.save
            redirect_to movie_reviews_path(@movie), notice: "Review Successfully Submitted!"
        else 
            render :new 
        end
    end



private

    def set_up
        @movie = Movie.find(params[:movie_id])
    end

    def review_params
        params.require(:review).permit(:name, :comment, :stars)
    end
end
