class Api::V1::MerchantsController < ApplicationController
   respond_to :json, :xml, :html

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def most_revenue
    binding.pry
    respond_with Merchant.most_revenue_merchant(params[:quantity])
  end

  def most_items
    respond_with Merchant.most_items_merchant(params[:quantity])
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
    respond_with Merchant.revenue_to_merchant(params[:id])
  end

  def favorite_customer
    respond_with Merchant.top_customer(params[:id])
  end

  def customers_with_pending_invoices
    respond_with Merchant.pending_invoice(params[:id])
  end

  private
  def merchant_params
    params.permit(:name, :created_at, :updated_at,:id)
  end
end
