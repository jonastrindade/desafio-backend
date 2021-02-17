require 'rails_helper'

RSpec.describe CongressPerson::Entity, type: :model do

  before(:all) do
    @congress_person = build(:congress_person)
  end
  
  it "registration field" do
    expect(@congress_person.registration_id).to eq("777")
  end

end

# factory :congress_person, class: 'CongressPerson::Entity' do
#   uploads_id { 1 }
#   registration_id { "777" }
#   name { "Aecio Neves" }
#   cpf { "11111111111" }
#   state { "MG" }
#   party { "PSDB" }
# end
