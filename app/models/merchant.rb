class Merchant < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  has_many :items
  has_many :invoices

  def self.random
    order("RANDOM()").first
  end

  def calc_items
    invoices.succesful.joins(:invoice_items).sum(:quantity)
  end

  def calc_revenue
    invoices.succesful.joins(:invoice_items).sum("unit_price * quantity")
  end

  def self.most_items(quantity)
    all.sort_by(&:calc_items).reverse[0...quantity.to_i]
  end

  def self.most_revenue(quantity)
    all.sort_by(&:calc_revenue).reverse[0...quantity.to_i]
  end
end
