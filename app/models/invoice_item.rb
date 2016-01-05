class InvoiceItem < ActiveRecord::Base
  default_scope -> { order('id DESC') }
  belongs_to :item
  belongs_to :invoice

  def self.currency_format
    self.unit_price = unit_pice/100.00
  end

  def self.random
    order("RANDOM()").first
  end

end
