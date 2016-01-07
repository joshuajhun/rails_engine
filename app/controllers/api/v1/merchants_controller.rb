class Api::V1::MerchantsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    if params['name']
      respond_with Merchant.find_by("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Merchant.find_by(params.first.first => params.first.last)
    end
  end

  def find_all
    if params['name']
      respond_with Merchant.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Merchant.where(params.first.first => params.first.last)
    end
  end

  def most_revenue
    respond_with Merchant.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity])
  end

  def random
    respond_with Merchant.random
  end

  def items
    respond_with Merchant.find(params[:id]).items
  end

  def invoices
    respond_with Merchant.find(params[:id]).invoices
  end

  def revenue
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    revenue = InvoiceItem.where(invoice_id: paid_invoice_ids).sum("unit_price * quantity")
    respond_with({"revenue" => revenue })
  end

  def favorite_customer
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    paid_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    customer_ids_array = Invoice.find(paid_invoice_ids).map { |invoice| invoice.customer_id }
    sales = customer_ids_array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    top_customer_id = customer_ids_array.max_by { |v| sales[v] }
    respond_with Customer.find(top_customer_id)
  end

  def customers_with_pending_invoices
    invoice_ids = Merchant.find(params[:id]).invoices.pluck(:id)
    pending_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "failed").pluck(:invoice_id)
    customer_ids = Invoice.find(pending_invoice_ids).map{|invoice| invoice.customer.id}
    respond_with Customer.find(customer_ids)
  end
end
