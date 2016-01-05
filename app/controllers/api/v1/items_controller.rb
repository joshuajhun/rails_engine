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
      respond_with Item.where("#{params.first.first} ILIKE ?", params.first.last).first
    else
      respond_with Item.where("#{params.first.first}": params.first.last).first
    end
  end

  def find_all
    if params['name'] || params['description']
      respond_with Item.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Item.where("#{params.first.first}": params.first.last)
    end
  end

  def random
    respond_with Item.random
  end
end
