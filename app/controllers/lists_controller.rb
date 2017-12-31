class ListsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @lists = List.all
  end

  def new
  end

  def edit
  end

  def show
  end
end
