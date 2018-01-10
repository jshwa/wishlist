class ListsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_list, only: [:edit, :update, :show]
  decorates_assigned :list

  def index
    @lists = List.all.decorate
    @gifts = Gift.all
  end

  def new
  end

  def edit
    if @list
      if @list.user == current_user
        render edit_list_path(@list)
      else
        redirect_to list_path(current_user.list)
      end
    else
      redirect_to root_path
    end
  end

  def update
    if @list.user == current_user
      @list.update(list_params)
      redirect_to list_path(@list)
    else
      redirect_to list_path(current_user.list)
    end
  end

  def show
    @list = List.find_by(id: params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:description)
  end

  def set_list
    @list = List.find_by(id: params[:id])
  end
end
