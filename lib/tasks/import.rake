  require 'csv'

namespace :data do
  task :import => :environment do

    merchant ="#{Rails.root}/lib/assets/merchants.csv"

    CSV.foreach(merchant, :headers => true) do |row|
      data = row.to_hash
      Merchant.create!(data)
      puts "created merchant #{data['name']}"
    end

    customer = "#{Rails.root}/lib/assets/customers.csv"

    CSV.foreach(customer, :headers => true) do |row|
      data = row.to_hash
      Customer.create!(data)
      puts "created  Customer #{data['first_name']}"
    end

    invoices = "#{Rails.root}/lib/assets/invoices.csv"

    CSV.foreach(invoices, :headers => true) do |row|
      data = row.to_hash
      Invoice.create!(data)
      puts "created  invoice #{data['id']}"
    end

    transactions = "#{Rails.root}/lib/assets/transactions.csv"

    CSV.foreach(transactions, :headers => true) do |row|
      data = row.to_hash
      Transaction.create!(data)
      puts "created transation with credit_card_number #{data['credit_card_number']}"
    end

    item = "#{Rails.root}/lib/assets/items.csv"

    CSV.foreach(item, :headers => true) do |row|
      data = row.to_hash
      Item.create!(data)
      puts "created  #{data['name']}"
    end

    invoice_item = "#{Rails.root}/lib/assets/invoice_items.csv"

    CSV.foreach(invoice_item, :headers => true) do |row|
      data = row.to_hash
      InvoiceItem.create!(data)
      puts "created an invoice item with an item_id of  #{data['item_id']}"
    end
  end
end
