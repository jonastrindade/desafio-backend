class Api::V1::CongressPersons::CalculationsController < ApplicationController

  def index
    render :json =>{ calculations: CongressPerson::Calculation.all }.to_json
  end

end