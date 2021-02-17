class CongressPerson::Entity < ApplicationRecord
  self.table_name = "congress_person_entities"

  # Relations
  belongs_to :upload, class_name: "Upload", foreign_key: "uploads_id"
  has_many :expenses, class_name: "CongressPerson::Expense", foreign_key: "congress_person_entities_id"

  # Callbacks

end