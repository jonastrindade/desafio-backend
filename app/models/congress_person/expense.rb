class CongressPerson::Expense < ApplicationRecord
  self.table_name = "congress_person_expenses"

  # Relations
  belongs_to :congress_person, class_name: "CongressPerson::Entity", foreign_key: "congress_person_entities_id"

  # Callbacks

end