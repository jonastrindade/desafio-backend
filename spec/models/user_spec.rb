require 'rails_helper'

RSpec.describe User, type: :model do

  before(:all) do
    @user = build(:user)
  end
  
  it "is valid with valid attributes" do
    expect(@user.email).to eq("joe@gmail.com")
  end

end

# factory :user do
#   email { "joe@gmail.com" }
#   password { "blahblah" }
# end
