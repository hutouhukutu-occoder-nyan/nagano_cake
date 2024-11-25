class Item < ApplicationRecord

  has_many :cart_items
  has_many :order_details

  belongs_to :genre

  has_one_attached :item_image
  
  validates :item_image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  def with_tax_price
    (price * 1.1).floor
  end

  def get_item_image
    (item_image.attached?) ? item_image : 'no_image.jpg'
  end

end
