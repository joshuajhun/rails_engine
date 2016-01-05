class Api::V1::MerchantsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    if params.first.first == 'id'
      respond_with Merchant.find( params.first.last.to_i)
    else
      respond_with Merchant.where("#{params.first.first} ILIKE ?", params.first.last)
    end
  end
end
