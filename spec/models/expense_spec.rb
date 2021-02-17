require 'rails_helper'

RSpec.describe CongressPerson::Expense, type: :model do

  before(:all) do
    @expense = build(:expense)
  end
  
  it "is valid with valid attributes" do
    expect(@expense.provider).to eq("Uber")
  end

end

# factory :expense, class: 'CongressPerson::Expense' do
#   congress_person_entities_id { 1 }
#   issue_date { "Wed, 17 Feb 2021 06:26:59 UTC +00:00" }
#   provider { "Uber" }
#   net_value { 2000.00 }
#   document_url { "www.google.com" }
# end
