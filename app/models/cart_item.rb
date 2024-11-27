class CartItem < ApplicationRecord

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  
  belongs_to :customer
  belongs_to :item

  def subtotal
    item.with_tax_price * amount
  end
end
