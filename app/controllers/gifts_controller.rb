class GiftsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gift, only: [:update, :destroy]

  def index
    @gifts = Gift.search(params[:gift_search])
  end

  def new
    @gift = Gift.new
    @category = @gift.categories.build
  end

  def create
    @gift = Gift.new(gift_params)
    if @gift.save
      @gift.lists.push(current_user.list)
      redirect_to list_path(current_user.list)
    else
      @category = @gift.categories.build
      render :new
    end
  end

  def update

  end

  def show
    @gift = Gift.find_by(id: params[:id]).decorate
  end

  def destroy

  end

  private

  def gift_params
    params.require(:gift).permit(:name, :price, :url, :image, :description, :category_ids, :gift_search, lists: [], categories_attributes: [:name])
  end

  def set_gift
    if @gift = Gift.find_by(id: params[:id])
    else
      redirect_to gifts_path
    end
  end
end
