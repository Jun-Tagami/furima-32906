class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :ordersopen, only: [:index, :create]

  # 復習用→ログアウト状態のユーザーは、URLを直接入力して商品購入ページに遷移しようとすると、商品の販売状況に関わらずログインページに遷移すること

  def index
    # 復習用→フォームオブジェクトのインスタンスを生成し、インスタンス変数に代入する
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end
end

private

def order_params
  # 復習用→ 後々、requireを入力する（今はerrorができるので抜いている）
  params.require(:order_address).permit(:postal_code, :area_id, :municipalities, :house_number, :building_name, :phone_number).merge(
    user_id: current_user.id, item_id: params[:item_id], token: params[:token]
  )
end

# 復習用→ログイン状態の出品者が、URLを直接入力して自身の出品した商品購入ページに遷移しようとすると、トップページに遷移すること→自分が出品した商品の購入には行きたくない
# 復習用→ログイン状態のユーザーが、URLを直接入力して売却済み商品の商品購入ページへ遷移しようとすると、トップページに遷移すること

def ordersopen
  @item = Item.find(params[:item_id])
  redirect_to root_path if @item.user.id == current_user.id || !@item.order.nil?
end

def pay_item
  Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  Payjp::Charge.create(
    amount: @item.price,  # 商品の値段
    card: order_params[:token],    # カードトークン
    currency: 'jpy'                 # 通貨の種類（日本円）
  )
end
