class Merchant < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  has_many :items
  has_many :invoices
  def self.random
    order("RANDOM()").first
  end

end
