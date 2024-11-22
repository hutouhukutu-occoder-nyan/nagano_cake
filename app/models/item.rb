class Item < ApplicationRecord

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }

  has_many :cart_items
  has_many :order_details

  belongs_to :genre

def with_tax_price
  (price * 1.1).floor
end

  has_one_attached :item_image


  def get_item_image
    (item_image.attached?) ? item_image : 'no_image.jpg'
  end

end
