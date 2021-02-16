class CreateTableCongressPersonExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :congress_person_expenses do |t|
      t.timestamps
      t.references :congress_person_entities
      t.date :issue_date
      t.string :provider
      t.decimal :net_value
      t.string :document_url
    end
  end
end
