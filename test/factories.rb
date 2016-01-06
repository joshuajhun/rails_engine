FactoryGirl.define do

  factory :merchant do
    name "Super Store"
  end

  factory :customer do
    first_name 'Jhunbug'
    last_name 'stuff'
  end

  factory :item do
    name 'pizza'
    description 'it taste good'
    unit_price 50.00
    merchant
  end

  factory :transaction do
    invoice
    credit_card_number "12122121212122121"
    result 'Success'
  end

  factory :invoice_item do
    item
    invoice
    quantity 1
    unit_price 15000.00
  end

  factory :invoice do
    customer
    merchant
    status 'Success'
  end
end
