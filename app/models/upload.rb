class Upload < ApplicationRecord
  require 'smarter_csv'
  # include Rails.application.routes.url_helpers
  
  # Callbacks
  after_create_commit :create_data

  # Relations
  belongs_to :user
  has_many :congress_person_entities, class_name: "CongressPerson::Entity", foreign_key: "uploads_id"
  has_one_attached :csv_file


  def create_data
    data = SmarterCSV.process(ActiveStorage::Blob.service.path_for(self.csv_file.key), {col_sep: ','})

    upload_id = self.id
    congress_persons = Array.new

    data.each do |expense|

      if expense[:sguf] == "MG"
        if congress_persons.include?(expense[:txnomeparlamentar])
          congress_person = CongressPerson::Entity.find_by_name expense[:txnomeparlamentar]
          CongressPerson::Expense.create_expense congress_person.id, expense
        else
          congress_persons << expense[:txnomeparlamentar]
          congress_person = CongressPerson::Entity.create_congress_person upload_id, expense
          CongressPerson::Expense.create_expense congress_person.id, expense
        end
      end

    end
    CongressPerson::Entity.all_congress_person self.id

  end

end
