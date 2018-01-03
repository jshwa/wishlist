class ReviewsController < ApplicationController
  before_action :set_gift, only: [:index, :new]

  def index
  end

  def new
    @review = @gift.reviews.build
  end

  def edit
  end

  def show
  end

  private

  def set_gift
    @gift = Gift.find_by(id: params[:gift_id])
  end
end
