class Item < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  belongs_to :merchant
  has_many :invoice_items
  before_save :currency_format

  def self.random
    order("RANDOM()").first
  end

  def currency_format
    self.unit_price = unit_price / 100.00
  end
end
