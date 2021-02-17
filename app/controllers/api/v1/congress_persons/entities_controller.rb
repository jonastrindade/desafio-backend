class Api::V1::CongressPersons::EntitiesController < ApplicationController
  
  def index
    render :json =>{ congress_persons: CongressPerson::Entity.all }.to_json
  end

end