class ListsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  decorates_assigned :list

  def index
    @lists = List.all.decorate
    @gifts = Gift.all
  end

  def new
  end

  def edit
    @list = List.find_by(id: params[:id])
  end

  def update
    @list = List.find_by(id: params[:id])
    @list.update(list_params)
    redirect_to list_path(@list)
  end

  def show
    @list = List.find_by(id: params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:description)
  end
end
