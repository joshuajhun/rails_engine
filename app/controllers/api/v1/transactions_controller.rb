class Api::V1::TransactionsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    if params['credit_card_number'] || params['result']
      transaction = Transaction.where("#{params.first.first} ILIKE ?", params.first.last).first
    else
      transaction = Transaction.where("#{params.first.first}": params.first.last).first
    end
    respond_with transaction
  end

  def find_all
    if params['credit_card_number'] || params['result']
      transactions = Transaction.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      transactions = Transaction.where("#{params.first.first}": params.first.last)
    end
    respond_with transactions
  end

  def random
    respond_with Transaction.random
  end

  def invoice
    respond_with Transaction.find(params[:id]).invoice
  end
end
