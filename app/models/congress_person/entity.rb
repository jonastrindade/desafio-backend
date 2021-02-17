# os deputados que forem criados serao inseridos na tabela dessa model 

class CongressPerson::Entity < ApplicationRecord
  self.table_name = "congress_person_entities"

  # Relations
  belongs_to :upload, class_name: "Upload", foreign_key: "uploads_id"
  has_one :calculation, class_name: "CongressPerson::Calculation", foreign_key: "congress_person_entities_id"
  has_many :expenses, class_name: "CongressPerson::Expense", foreign_key: "congress_person_entities_id"

  # Callbacks
  after_create :create_calculation

  # callback usado após a criacao de cada deputado, ele gera um calculation vazia que corresponde a análise de dados
  def create_calculation
    CongressPerson::Calculation.create_calculation self.id
  end

  # buscamos no banco de dados os deputados criados pelo arquivo csv através do nome
  def self.find_by_name name
    CongressPerson::Entity.find_by(name: name)
  end

  # metodo para criar um deputado a partir de uma linha do arquivo csv upado
  def self.create_congress_person upload_id, expense
    CongressPerson::Entity.create!(uploads_id: upload_id, registration_id: expense[:idecadastro], name: expense[:txnomeparlamentar], cpf: expense[:cpf], state: expense[:sguf], party: expense[:sgpartido])
  end

  # busca todos os deputados ja criados na base para enviar ao front end
  # usado na api de deputados index
  def self.all_congress_person upload_id
    CongressPerson::Entity.where(uploads_id: upload_id).each do |congress_person|
      CongressPerson::Calculation.update_calculation congress_person
    end
  end

end

# create_table "congress_person_entities", force: :cascade do |t|
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.bigint "uploads_id"
#   t.string "registration_id"
#   t.string "name"
#   t.string "cpf"
#   t.string "state"
#   t.string "party"
#   t.index ["uploads_id"], name: "index_congress_person_entities_on_uploads_id"
# end