class ItemsController < ApplicationController

  # force users to be logged in to see this page
  before_action :force_login

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

end
