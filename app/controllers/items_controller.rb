class ItemsController < ApplicationController
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

  # 以下コントローラーの実装ができていないと入力できないので保留（chatappを参考にしてます）
  def items_params
    params.require(:item).permit(:category_id, :status_id, :delivery_fee_id, :area_id, :ship_id, :image, :product_name,
                                 :explanation, :price).merge(user_id: current_user.id)
  end
end
