# as analises de dados geradas por deputado sao inseridas na tabela dessa model

class CongressPerson::Calculation < ApplicationRecord
  self.table_name = "calculations"

  # Relations
  belongs_to :congress_person, class_name: "CongressPerson::Entity", foreign_key: "congress_person_entities_id"

  # Callbacks

  # esse metodo e usado pelos uploads para gerar uma linha na tabela da análise de dados toda zerada
  def self.create_calculation congress_person_id
    CongressPerson::Calculation.create!(congress_person_entities_id: congress_person_id, net_value_sum: 0, net_value_max: 0, net_value_min: 0)
  end

  # esse metodo e usado pelos uploads para fazer update na tabela de análise de dados que foi criada zerada
  def self.update_calculation congress_person
    congress_person.calculation.update(net_value_sum: congress_person.expenses.sum(:net_value), net_value_max: congress_person.expenses.max_by(&:net_value).net_value.to_i, net_value_min: congress_person.expenses.min_by(&:net_value).net_value.to_i)
  end

end

# create_table "calculations", force: :cascade do |t|
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.bigint "congress_person_entities_id"
#   t.decimal "net_value_sum"
#   t.decimal "net_value_max"
#   t.decimal "net_value_min"
#   t.index ["congress_person_entities_id"], name: "index_calculations_on_congress_person_entities_id"
# end