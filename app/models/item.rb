class Item < ActiveRecord::Base
  belongs_to :merchant

  def self.random
    order("RANDOM()").first
  end

  def self.currency_format
    self.unit_price = unit_pice/100.00
  end
end
