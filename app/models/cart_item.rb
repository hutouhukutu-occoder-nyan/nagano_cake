class CartItem < ApplicationRecord

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  
  belongs_to :customer
  belongs_to :item

  def subtotal
    item.with_tax_price * amount
  end
end

# subtotalをinteger型に変換する必要があるので、(item.with_tax_price * amount).to_iへ修正する必要がある