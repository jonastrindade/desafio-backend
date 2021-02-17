class Api::V1::CongressPersons::EntitiesController < ApplicationController
  
  # rota para api list de deputados
  def index
    render :json =>{ congress_persons: CongressPerson::Entity.all }.to_json
  end

end