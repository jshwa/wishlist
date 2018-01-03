class ReviewsController < ApplicationController
  def index
    @gift = Gift.find_by(id: params[:gift_id])
  end

  def new
  end

  def edit
  end

  def show
  end
end
