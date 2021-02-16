class CongressPerson::Entity < ApplicationRecord
  self.table_name = "congress_person_entities"

  # Relations
  has_many :expenses, class_name: "CongressPerson::Expense", foreign_key: "congress_person_entities_id"

  # Callbacks

end