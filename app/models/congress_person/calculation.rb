class CongressPerson::Calculation < ApplicationRecord
  self.table_name = "calculations"

  # Relations
  belongs_to :congress_person, class_name: "CongressPerson::Entity", foreign_key: "congress_person_entities_id"

  # Callbacks

  def self.create_calculation congress_person_id
    CongressPerson::Calculation.create!(congress_person_entities_id: congress_person_id, net_value_sum: 0, net_value_max: 0, net_value_min: 0)
  end

  def self.update_calculation congress_person
    congress_person.calculation.update(net_value_sum: congress_person.expenses.sum(:net_value), net_value_max: congress_person.expenses.max_by(&:net_value).net_value.to_i, net_value_min: congress_person.expenses.min_by(&:net_value).net_value.to_i)
  end

end