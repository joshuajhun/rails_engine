class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def find
    respond_with Item.find_by(items_params)
  end

  def find_all
    respond_with Item.where(items_params)
  end

  def random
    respond_with Item.random
  end

  def invoice_items
    respond_with Item.find(params[:id]).invoice_items
  end

  def merchant
    respond_with Item.find(params[:id]).merchant
  end

  def best_day
    respond_with ({ "best_day" => Item.joins(:invoice_items).where(id: params[:id]).group("items.id,date(invoice_items.created_at)").count.keys[0]})
  end

  private
  def items_params
    params.permit(:id, :description, :unit_price, :merchant_id, :created_at, :updated_at, :name)
  end
end
