class ApplicationController < ActionController::Base
  protect_from_forgery

  # ApplicationControllerを継承する他のコントローラから利用できるメソッド
  private

    # ショッピングカートをセッションに保存する
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
