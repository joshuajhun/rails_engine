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
      respond_with Merchant.where("#{params.first.first} ILIKE ?", params.first.last).first
    else
      respond_with Merchant.where("#{params.first.first}": params.first.last).first
    end
  end

  def find_all
    if params['name']
      respond_with Merchant.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Merchant.where("#{params.first.first}": params.first.last)
    end
  end
end
