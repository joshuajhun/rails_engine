class InvoiceItem < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  belongs_to :item
  belongs_to :invoice
  before_save :currency_format

  def currency_format
    self.unit_price = unit_price/100.00
  end

  def self.random
    order("RANDOM()").first
  end

end
