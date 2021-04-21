class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  
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

  private
  def items_params
    params.require(:item).permit(:category_id, :status_id, :delivery_fee_id, :area_id, :ship_id, :image, :product_name,
                                 :explanation, :price).merge(user_id: current_user.id)
  end

  # def move_to_index
  #   unless user_signed_in?
  #     redirect_to action: :index
  #   end
  # end
end
