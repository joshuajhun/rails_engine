class Customer < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.random
    order("RANDOM()").first
  end

  def self.currency_format
    self.unit_price    = unit_pice/100.00
  end

  def self.fav_merchant(id)
    invoice_ids_array  = Customer.find(id).transactions.where(result: "success").pluck(:invoice_id)
    merchant_ids_array = Invoice.find(invoice_ids_array).map { |invoice| invoice.merchant_id }
    sales              = merchant_ids_array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    top_merch_id       = merchant_ids_array.max_by { |v| sales[v] }
    Merchant.find(top_merch_id)
  end
end
