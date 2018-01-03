class GiftsController < ApplicationController
  before_action :set_gift, only: [:show, :update]

  def index
    @gifts = Gift.search(params[:gift_search])
  end

  def new
    @gift = Gift.new
    @category = @gift.categories.build
  end

  def create
    gift = Gift.new(gift_params)
    gift.save
    gift.lists.push(current_user.list)
    redirect_to list_path(current_user.list)
  end

  def update
    if @gift.users.where(id: current_user.id).exists?
      flash[:notice] = " #{@gift.name}is already on your wishlist"
      redirect_to list_path(current_user.list)
    else
      @gift.lists.push current_user.list
      redirect_to list_path(current_user.list)
    end
  end

  def show
  end

  private

  def gift_params
    params.require(:gift).permit(:name, :price, :url, :image, :description, :gift_search, lists: [], categories_attributes: [:name])
  end

  def set_gift
    @gift = Gift.find_by(id: params[:id])
  end
end
