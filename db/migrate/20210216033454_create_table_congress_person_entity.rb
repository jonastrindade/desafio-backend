class CreateTableCongressPersonEntity < ActiveRecord::Migration[6.0]
  def change
    create_table :congress_person_entities do |t|
      t.timestamps
      t.string :registration_id
      t.string :name
      t.string :cpf
      t.string :state
      t.string :party
    end
  end
end
