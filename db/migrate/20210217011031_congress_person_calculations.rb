class CongressPersonCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :calculations do |t|
      t.timestamps
      t.references :congress_person_entities
      t.decimal :net_value_sum
      t.decimal :net_value_max
      t.decimal :net_value_min
    end
  end
end
