class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def find
    if params['name'] || params['description']
      respond_with Item.find_by("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Item.find_by(params.first.first => params.first.last)
    end
  end

  def find_all
    if params['name'] || params['description']
      respond_with Item.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Item.where(params.first.first => params.first.last)
    end
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

end
