class LineItem < ActiveRecord::Base
  attr_accessible :product, :cart_id, :product_id, :quantity

  # line_itemテーブルの行はcartsテーブルとproductsテーブル内にある行の子
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end
end
