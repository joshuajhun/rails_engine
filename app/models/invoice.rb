  class Invoice < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.random
    order("RANDOM()").first
  end

  def self.succesful
    joins(:transactions).where("result = 'success'")
  end
end
