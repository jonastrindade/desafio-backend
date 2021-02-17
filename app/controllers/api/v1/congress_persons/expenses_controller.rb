class Api::V1::CongressPersons::ExpensesController < ApplicationController

  # rota para api list de gastos
  def index
    render :json =>{ expenses: CongressPerson::Expense.all }.to_json
  end
  
end