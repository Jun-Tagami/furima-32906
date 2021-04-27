class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(items_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

 def show
  @item = Item.find(params[:id])
 end 
 
 def edit
  @item = Item.find(params[:id])
 end 

 def update
  # if update
  # item = Item.find(params[:id])
  # item.update(items_params)
  @item = Item.find(params[:id])
  if @item.update(items_params)
    redirect_to root_path
  else
    render :edit
  end
 end

  private
  def items_params
    params.require(:item).permit(:category_id, :status_id, :delivery_fee_id, :area_id, :ship_id, :image, :product_name,:explanation, :price).merge(user_id: current_user.id)
  end

end
