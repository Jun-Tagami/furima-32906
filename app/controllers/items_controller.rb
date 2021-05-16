class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :set_item_user, only: [:edit, :update, :destroy]
  before_action :set_order, only: [:edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
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
  end

  def edit

  end

  def update
    if @item.update(items_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def items_params
    params.require(:item).permit(:category_id, :status_id, :delivery_fee_id, :area_id, :ship_id, :image, :product_name,
                                 :explanation, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_item_user
    redirect_to action: :index unless @item.user.id == current_user.id
  end

  def set_order
    redirect_to action: :index unless @item.order == nil
  end

end

class Form
  # validation

  def save
    Order.create
    Address.create
  end
end

def create
  @form = Form.new(items_params)
  if @form.save
    redirect_to root_path
  else
    render :new
  end
end
