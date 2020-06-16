class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    card = Card.where(user_id: current_user.id).first
    # if card.blank?
    #   #登録された情報がない場合にカード登録画面に移動
    #   redirect_to new_card_path
    # else
    # Payjp.api_key = "sk_test_6d5bbe82c50db611a63aeefa"
    # #保管した顧客IDでpayjpから情報取得
    # customer = Payjp::Customer.retrieve(card.customer_id)
    # #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    # @default_card_information = customer.cards.retrieve(card.card_id)
    # end
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path
    elsif current_user.destinations.blank? then
      redirect_to new_destination_path
    elsif @item.buyer_id || @item.id.blank then
      redirect_to root_path
    else
    Payjp.api_key = "sk_test_6d5bbe82c50db611a63aeefa"
    #保管した顧客IDでpayjpから情報取得
    customer = Payjp::Customer.retrieve(card.customer_id)
    #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def buy
    @item = Item.find(params[:item_id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = "sk_test_6d5bbe82c50db611a63aeefa"
    Payjp::Charge.create(
    :amount => @item.price,
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy' #日本円
  )
  @item.update( buyer_id: current_user.id)
  # redirect_to action: 'done' #完了画面に移動
  redirect_to root_path
  end

  # def done
  # end
end
