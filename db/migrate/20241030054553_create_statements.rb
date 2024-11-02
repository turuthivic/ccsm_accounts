class CreateStatements < ActiveRecord::Migration[8.0]
  def change
    create_table :statements do |t|
      t.string :name, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.references :user, null: false, foreign_key: true
      t.json :extracted_data
      t.datetime :uploaded_at
      t.json :uploaded_by
      t.json :data
      t.string :error

      t.timestamps
    end
  end
end
