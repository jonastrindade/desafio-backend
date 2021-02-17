require 'rails_helper'

RSpec.describe CongressPerson::Calculation, type: :model do
  
  before(:all) do
    @calculation = build(:calculation)
  end

  it "is valid with valid attributes" do
    expect(@calculation.net_value_sum).to eq(2000)
  end

end

# factory :calculation, class: 'CongressPerson::Calculation' do
#   congress_person_entities_id { 1 }
#   net_value_sum { 2000 }
#   net_value_max { 500 }
#   net_value_min { 1 }
# end
