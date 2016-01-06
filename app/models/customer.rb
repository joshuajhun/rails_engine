class Customer < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.random
    order("RANDOM()").first
  end

  def self.currency_format
    self.unit_price = unit_pice/100.00
  end
end
