class ListsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_list, only: [:edit, :update, :show]

  def index
    @lists = List.all
    @gifts = Gift.all
  end

  def edit
    if @list
      if @list.user == current_user
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
      respond_to do |format|
        format.html {redirect_to list_path(@list)}
        format.json { render json: @list}
      end
    else
      redirect_to list_path(current_user.list)
    end
  end

  def show
    if @list
      render :show
    else
      redirect_to root_path
    end
  end

  private

  def list_params
    params.require(:list).permit(:description)
  end

  def set_list
    @list = List.find_by(id: params[:id])
  end
end
