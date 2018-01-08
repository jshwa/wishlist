class GiftsController < ApplicationController
  before_action :set_gift, only: [:update, :destroy]

  def index
    @gifts = Gift.search(params[:gift_search])
  end

  def new
    @gift = Gift.new
    @category = @gift.categories.build
  end

  def create
    if user_signed_in?
      gift = Gift.new(gift_params)
      gift.save
      gift.lists.push(current_user.list)
      redirect_to list_path(current_user.list)
    else
      redirect_to new_user_session_path
    end
  end

  def update
    if user_signed_in?
      if @gift.users.where(id: current_user.id).exists?
        flash[:notice] = " #{@gift.name} is already on your wishlist"
        redirect_to list_path(current_user.list)
      else
        @gift.lists.push current_user.list
        redirect_to list_path(current_user.list)
      end
    else
      redirect_to new_user_session_path
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
