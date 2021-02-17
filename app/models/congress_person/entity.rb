class CongressPerson::Entity < ApplicationRecord
  self.table_name = "congress_person_entities"

  # Relations
  belongs_to :upload, class_name: "Upload", foreign_key: "uploads_id"
  has_one :calculation, class_name: "CongressPerson::Calculation", foreign_key: "congress_person_entities_id"
  has_many :expenses, class_name: "CongressPerson::Expense", foreign_key: "congress_person_entities_id"

  # Callbacks
  after_create :create_calculation

  def create_calculation
    CongressPerson::Calculation.create_calculation self.id
  end

  def self.find_by_name name
    CongressPerson::Entity.find_by(name: name)
  end

  def self.create_congress_person upload_id, expense
    CongressPerson::Entity.create!(uploads_id: upload_id, registration_id: expense[:idecadastro], name: expense[:txnomeparlamentar], cpf: expense[:cpf], state: expense[:sguf], party: expense[:sgpartido])
  end

  def self.all_congress_person upload_id
    CongressPerson::Entity.where(uploads_id: upload_id).each do |congress_person|
      CongressPerson::Calculation.update_calculation congress_person
    end
  end

end