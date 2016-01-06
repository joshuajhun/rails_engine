class Api::V1::InvoicesController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def find
    if params['status']
      respond_with Invoice.find_by("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Invoice.find_by(params.first.first => params.first.last)
    end
  end

  def find_all
    if params['status']
      respond_with Invoice.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Invoice.where("#{params.first.first}": params.first.last)
    end
  end

  def random
    respond_with Invoice.random
  end

  def transactions
    respond_with Invoice.find(params[:id]).transactions
  end

  def invoice_items
    respond_with Invoice.find(params[:id]).invoice_items
  end

  def items
    respond_with Invoice.find(params[:id]).items
  end

  def customer
    respond_with Invoice.find(params[:id]).customer
  end

  def merchant
    respond_with Invoice.find(params[:id]).merchant
  end
end
