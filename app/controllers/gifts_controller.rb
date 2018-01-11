class GiftsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gift, :check_permissions, only: [:edit, :update, :destroy]

  def index
    @gifts = Gift.search(params[:gift_search])
  end

  def new
    @gift = Gift.new
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.created_by = current_user.id
    if @gift.save
      @gift.lists.push(current_user.list)
      redirect_to gift_path(@gift)
    else
      render :new
    end
  end

  def update
    @gift.update(gift_params)
    redirect_to gift_path(@gift)
  end

  def show
    @gift = Gift.find_by(id: params[:id]).decorate
  end

  def destroy
    @gift.destroy
    redirect_to list_path(current_user)
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

  def check_permissions
    unless @gift.created_by == current_user.id
      redirect_to gift_path(@gift) || gifts_path
    end
  end
end
