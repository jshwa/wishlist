class GiftsController < ApplicationController
  def index
  end

  def new
    @gift = Gift.new
    @category = @gift.categories.build
  end

  def create
    gift = Gift.new(gift_params)
    gift.save
    gift.lists << current_user.list
    redirect_to list_path(current_user.list.id)
  end

  def edit

  end

  private

  def gift_params
    params.require(:gift).permit(:name, :description, lists: [], categories_attributes: [:name])
  end
end
