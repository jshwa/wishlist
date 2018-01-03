class ReviewsController < ApplicationController
  before_action :set_gift, only: [:index, :new, :create]

  def index
  end

  def new
    @review = @gift.reviews.build
  end

  def create
    review = @gift.reviews.build(review_params)
    review.user = current_user
    if review.save
      redirect_to gift_review_path(@gift, review)
    else
      flash[:alert] = "There was a problem saving your review"
      render new_gift_review(@gift)
    end
  end

  def edit
  end

  def show
    @review = Review.find_by(id: params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:stars, :comment)
  end

  def set_gift
    @gift = Gift.find_by(id: params[:gift_id])
  end
end
