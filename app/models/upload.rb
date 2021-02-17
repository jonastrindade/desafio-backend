# gerado pelo rails scaffolds, integrado com active storage para uploads 
# a tabela dessa model armazena os arquivos upados

class Upload < ApplicationRecord
  require 'smarter_csv'
  # include Rails.application.routes.url_helpers
  
  # Callbacks
  after_create_commit :create_data

  # Relations
  belongs_to :user
  has_many :congress_person_entities, class_name: "CongressPerson::Entity", foreign_key: "uploads_id"
  has_one_attached :csv_file


  # esse metodo e usado após o upload do arquivo, ela gera os nosso deputaados, gastos e cálculos de maior, menor e soma dos gastos
  def create_data
    data = SmarterCSV.process(ActiveStorage::Blob.service.path_for(self.csv_file.key), {col_sep: ','})

    # cada deputado recebe o id do upload para ficar vinculado a um arquivo
    upload_id = self.id

    # array que adiciono deputados para chegar se eles ja foram criados no nosso banco
    congress_persons = Array.new

    # loopamos por cada linha do arquivo e chamamos suas models de acordo com estado
    data.each do |expense|
      
      # falta implementar: receber estado como parametro para conseguir criar análises de outros estados além de MG
      if expense[:sguf] == "MG"
        if congress_persons.include?(expense[:txnomeparlamentar])
          # quando o deputado ja foi criado na base criamos apenas um gasto e vinculamos a ele
          congress_person = CongressPerson::Entity.find_by_name expense[:txnomeparlamentar]
          CongressPerson::Expense.create_expense congress_person.id, expense
        else
          # quando o deputado nao foi criado na base criamos ele e um gasto 
          congress_persons << expense[:txnomeparlamentar]
          congress_person = CongressPerson::Entity.create_congress_person upload_id, expense
          CongressPerson::Expense.create_expense congress_person.id, expense
        end
      end

    end
    # depois de todos objetos terem sido criados podemos gerar algumas análises solicitads a patir desse metodo
    # primeiro encontramos todos deputados vinculados ao arquivo recem gerado
    CongressPerson::Entity.all_congress_person self.id

  end

end

# create_table "uploads", force: :cascade do |t|
#   t.integer "year"
#   t.bigint "user_id", null: false
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.index ["user_id"], name: "index_uploads_on_user_id"
# end
