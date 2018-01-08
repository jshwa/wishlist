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
  end

  def show
    @list = List.find_by(id: params[:id])
  end
end
