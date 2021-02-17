class Api::V1::CongressPersons::ExpensesController < ApplicationController

  def index
    render :json =>{ expenses: CongressPerson::Expense.all }.to_json
  end
  
end