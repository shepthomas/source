class ItemsController < ApplicationController

  # force users to be logged in to see this page
  before_action :force_login

  def index
    # if theres a search, filter
    # if not, show all
    if params[:q].present?
      @items = Item.where("lower(title) LIKE ?", "%"+params[:q].downcase+"%")
    else
      @items = Item.all
    end

  end

  def show
    @item = Item.find(params[:id])
  end

end
