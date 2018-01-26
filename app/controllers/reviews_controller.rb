class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gift, only: [:show, :new, :edit, :create, :destroy]
  before_action :check_already_reviewed, only: [:new, :create]
  before_action :check_valid_url, only: [:show, :edit, :destroy]
  before_action :check_correct_user, only: [:edit, :destroy]

  def index
    @gift = params[:gift_id] ? Gift.find_by(id: params[:gift_id]) : nil
    @user = params[:user_id] ? User.find_by(id: params[:user_id]) : nil
    if obj = @user || @gift
      @reviews = obj.reviews.decorate
      respond_to do |format|
        format.html
        format.json { render json: @reviews, each_serializer: ReviewSerializer }
      end
    else
      redirect_to root_path, alert: 'Page not found'
    end
  end

  def new
    @review = @gift.reviews.build
  end

  def create
    @review = @gift.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to gift_review_path(@gift, @review)
    else
      flash[:alert] = "There was a problem saving your review"
      render :new
    end
  end

  def update
    @review = Review.find_by(id: params[:id])
    if @review.user != current_user
      redirect_to gift_reviews_path(@review.gift)
    else
      @review.update(review_params)
      redirect_to gift_review_path(@review.gift, @review)
    end
  end

  def destroy
    @review.destroy
    redirect_to gift_reviews_path(@gift)
  end

  private

  def review_params
    params.require(:review).permit(:stars, :comment)
  end

  def set_gift
    @gift = params[:gift_id] ? Gift.find_by(id: params[:gift_id]) : nil
    if @gift.nil?
      redirect_to gifts_path, alert: "Gift not found"
    end
  end

  def check_valid_url
    @review = @gift.reviews.find_by(id: params[:id])
    if @review.nil?
      redirect_to gift_reviews_path(@gift), alert: "Review not found"
    end
  end

  def check_correct_user
    if @review.user != current_user
      redirect_to gift_reviews_path(@gift)
    end
  end

  def check_already_reviewed
    if review = current_user.wrote_a_review?(@gift)
      redirect_to edit_gift_review_path(@gift, review)
    end
  end
end
