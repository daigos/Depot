class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  attr_accessible :description, :image_url, :price, :title

  # 存在するかどうか
  validates :title, :description, :image_url, presence: true

  # 数値かつ0.01以上の値
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  # タイトルはユニーク
  validates :title, uniqueness: true

  # タイトルは10文字以上
  validates :title, length: {
    minimum: 10,
    too_short: 'は10文字以上入力してください'
  }

  # image_urlはgif/jpg/png
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)$}i,
    message: 'はGIF、JPG、PNG画像のURLでなければなりません'
  }

  private

    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, '品目が存在します')
        return false
      end
    end
end
