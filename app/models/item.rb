class Item < ActiveRecord::Base
  default_scope -> { order('id DESC') }
  belongs_to :merchant
  has_many :invoice_items

  def self.random
    order("RANDOM()").first
  end

  def self.currency_format
    self.unit_price = unit_pice/100.00
  end
end
