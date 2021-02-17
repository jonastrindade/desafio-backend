class CongressPerson::Expense < ApplicationRecord
  self.table_name = "congress_person_expenses"

  # Relations
  belongs_to :congress_person, class_name: "CongressPerson::Entity", foreign_key: "congress_person_entities_id"

  # Callbacks

  def self.create_expense congress_person_id, expense
    expense[:datemissao].present? ? issue_date = expense[:datemissao].to_date : isse_date = "2020-01-01".to_date.end_of_year
    CongressPerson::Expense.create!(congress_person_entities_id: congress_person_id, issue_date: issue_date, provider: expense[:txtfornecedor], net_value: expense[:vlrliquido], document_url: expense[:urldocumento])
  end

end