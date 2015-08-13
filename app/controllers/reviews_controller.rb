class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.endorsements.any?
      # @review.endorsements.each { |endorsement| endorsement.destroy }
      flash[:notice] = 'this review cannot be destroyed yet. Guillaume is working on a solution'
    else
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
    end
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
