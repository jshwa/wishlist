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
    if @gift.users.where(id: current_user.id).exists?
      flash[:notice] = " #{@gift.name} is already on your wishlist"
      redirect_to list_path(current_user.list)
    else
      @gift.lists.push current_user.list
      redirect_to list_path(current_user.list)
    end
  end

  def show
    @gift = Gift.find_by(id: params[:id]).decorate
  end

  def destroy
    if @gift.users.include?(current_user)
      @gift.lists.delete(current_user.list)
      redirect_to list_path(current_user.list)
    else
      redirect_to gift_path(@gift)
    end
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
