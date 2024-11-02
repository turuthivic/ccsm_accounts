class CreateJournalEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :journal_entries do |t|
      t.integer :type, null: false
      t.float :amount, null: false
      t.datetime :value_date
      t.datetime :creation_date
      t.references :statement, null: false, foreign_key: true
      t.string :error
      t.json :data

      t.timestamps
    end
  end
end
