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
      expense[:datemissao].present? ? issue_date = expense[:datemissao].to_date : isse_date = "2020-01-01".to_date.end_of_year
      if expense[:sguf] == "MG"
        if congress_persons.include?(expense[:txnomeparlamentar])
          congress_person = CongressPerson::Entity.find_by(name: expense[:txnomeparlamentar])
          CongressPerson::Expense.create!(congress_person_entities_id: congress_person.id, issue_date: issue_date, provider: expense[:txtfornecedor], net_value: expense[:vlrliquido], document_url: expense[:urldocumento])
        else
          congress_persons << expense[:txnomeparlamentar]
          congress_person = CongressPerson::Entity.create!(uploads_id: upload_id, registration_id: expense[:idecadastro], name: expense[:txnomeparlamentar], cpf: expense[:cpf], state: expense[:sguf], party: expense[:sgpartido])
          CongressPerson::Expense.create!(congress_person_entities_id: congress_person.id, issue_date: issue_date, provider: expense[:txtfornecedor], net_value: expense[:vlrliquido], document_url: expense[:urldocumento])
        end
      end
    end
  end

end
