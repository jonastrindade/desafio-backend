# as despesas gerados sao adicionadas na tabela dessa model

class CongressPerson::Expense < ApplicationRecord
  self.table_name = "congress_person_expenses"

  # Relations
  belongs_to :congress_person, class_name: "CongressPerson::Entity", foreign_key: "congress_person_entities_id"

  # Callbacks

  # a partir de um deputado e uma linha do arquivo csv e gerado um deputado
  def self.create_expense congress_person_id, expense
    expense[:datemissao].present? ? issue_date = expense[:datemissao].to_date : isse_date = "2020-01-01".to_date.end_of_year
    CongressPerson::Expense.create!(congress_person_entities_id: congress_person_id, issue_date: issue_date, provider: expense[:txtfornecedor], net_value: expense[:vlrliquido], document_url: expense[:urldocumento])
  end

end

# create_table "congress_person_expenses", force: :cascade do |t|
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.bigint "congress_person_entities_id"
#   t.date "issue_date"
#   t.string "provider"
#   t.decimal "net_value"
#   t.string "document_url"
#   t.index ["congress_person_entities_id"], name: "index_congress_person_expenses_on_congress_person_entities_id"
# end