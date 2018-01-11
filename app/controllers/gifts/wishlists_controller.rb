class Gifts::WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gift, only: [:update, :destroy]

  def update
    if @gift.users.where(id: current_user.id).exists?
      flash[:notice] = " #{@gift.name} is already on your wishlist"
      redirect_to list_path(current_user.list)
    else
      @gift.lists.push current_user.list
      redirect_to list_path(current_user.list)
    end
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

  def set_gift
    if @gift = Gift.find_by(id: params[:id])
    else
      redirect_to gifts_path
    end
  end

end
