class Upload < ApplicationRecord
  require 'smarter_csv'
  # include Rails.application.routes.url_helpers
  
  # Callbacks
  after_create_commit :create_data

  # Relations
  belongs_to :user
  has_one_attached :csv_file


  def create_data
    data = SmarterCSV.process(ActiveStorage::Blob.service.path_for(self.csv_file.key), {col_sep: ','})

    deputados = Array.new
    # deputados_object = Array.new 
    data.each do |expense|
      if expense[:sguf] == "MG"
        if deputados.include?(expense[:txnomeparlamentar])
          congress_person = CongressPerson::Entity.find_by(name: expense[:txnomeparlamentar])
          CongressPerson::Expense.create(congress_person_entities_id: congress_person.id, issue_date: expense[:dataemissao], provider: expense[:txtfornecedor], net_value: expense[:vlrliquido], document_url: expense[:urldocumento])
        else
          deputados << expense[:txnomeparlamentar]
          congress_person = CongressPerson::Entity.create(registration_id: expense[:idecadastro], name: expense[:txnomeparlamentar], cpf: expense[:cpf], state: expense[:sguf], party: expense[:sgpartido])
          CongressPerson::Expense.create(congress_person_entities_id: congress_person.id, issue_date: expense[:dataemissao], provider: expense[:txtfornecedor], net_value: expense[:vlrliquido], document_url: expense[:urldocumento])
        end
      end
    end
  end

end
