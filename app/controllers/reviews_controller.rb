class ReviewsController < ApplicationController
  before_action :set_gift, only: [:index, :new, :create]
  before_action :set_review, only: [:show, :edit, :update]

  def index
  end

  def new
    review = current_user.wrote_a_review?(@gift)
    if review
      redirect_to edit_gift_review_path(@gift, review)
    else
      @review = @gift.reviews.build
    end
  end

  def create
    review = current_user.wrote_a_review?(@gift)
    if review
      redirect_to edit_gift_review_path(@gift, review)
    else
      review = @gift.reviews.build(review_params)
      review.user = current_user
      if review.save
        redirect_to gift_review_path(@gift, review)
      else
        flash[:alert] = "There was a problem saving your review"
        render new_gift_review(@gift)
      end
    end
  end

  def edit
    if @review.user != current_user
      redirect_to gift_reviews_path(@review.gift)
    end
  end

  def update
    if @review.user != current_user
      redirect_to gift_reviews_path(@review.gift)
    else
      @review.update(review_params)
      redirect_to gift_review_path(@review)
    end
  end

  def show
  end

  private

  def review_params
    params.require(:review).permit(:stars, :comment)
  end

  def set_gift
    @gift = Gift.find_by(id: params[:gift_id])
  end

  def set_review
    @review = Review.find_by(id: params[:id])
  end
end
