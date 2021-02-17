FactoryBot.define do
  
  factory :user do
    email { "joe@gmail.com" }
    password { "blahblah" }
  end

  factory :congress_person, class: 'CongressPerson::Entity' do
    uploads_id { 1 }
    registration_id { "777" }
    name { "Aecio Neves" }
    cpf { "11111111111" }
    state { "MG" }
    party { "PSDB" }
  end

  factory :calculation, class: 'CongressPerson::Calculation' do
    congress_person_entities_id { 1 }
    net_value_sum { 2000 }
    net_value_max { 500 }
    net_value_min { 1 }
  end

  factory :expense, class: 'CongressPerson::Expense' do
    congress_person_entities_id { 1 }
    issue_date { "Wed, 17 Feb 2021 06:26:59 UTC +00:00" }
    provider { "Uber" }
    net_value { 2000.00 }
    document_url { "www.google.com" }
  end

  factory :upload do
    year { 2020 }
    user_id { 1 }
    csv_file { Rack::Test::UploadedFile.new('path', '/home/jonas/Downloads/TP1.pdf') }
  end

end



