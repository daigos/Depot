class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  # 存在するかどうか
  validates :title, :description, :image_url, presence: true

  # 数値かつ0.01以上の値
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  # タイトルはユニーク
  validates :title, uniqueness: true

  # image_urlはgif/jpg/png
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)$}i,
    message: 'はGIF、JPG、PNG画像のURLでなければなりません'
  }
end
