class Api::V1::CongressPersons::CalculationsController < ApplicationController

  # rota para api list de analise de dados
  def index
    render :json =>{ calculations: CongressPerson::Calculation.all }.to_json
  end

end