class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gift, only: [:index, :show, :new, :edit, :create]
  before_action :set_review, only: [:update]

  def index
    @user = User.find_by(id: params[:user_id])
    if obj = @user || @gift
      @reviews = obj.reviews.decorate
    else
      redirect_to root_path, alert: 'Page not found'
    end
  end

  def new
    if @gift.nil?
      redirect_to gifts_path, alert: "Gift not found"
    else
      if review = current_user.wrote_a_review?(@gift)
        redirect_to edit_gift_review_path(@gift, review)
      else
        @review = @gift.reviews.build
      end
    end
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
    if @gift.nil?
      redirect_to gifts_path, alert: "Gift not found"
    else
      @review = @gift.reviews.find_by(id: params[:id])
      if @review.nil?
        redirect_to gift_reviews_path(@gift), alert: "Review not found"
      else
        if @review.user != current_user
          redirect_to gift_reviews_path(@gift)
        end
      end
    end
  end

  def update
    if @review.user != current_user
      redirect_to gift_reviews_path(@review.gift)
    else
      @review.update(review_params)
      redirect_to gift_review_path(@review.gift, @review)
    end
  end

  def show
    if @gift.nil?
      redirect_to gifts_path, alert: "Gift not found"
    else
      @review = @gift.reviews.find_by(id: params[:id])
      if @review.nil?
        redirect_to gift_reviews_path(@gift), alert: "Review not found"
      end
    end
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
