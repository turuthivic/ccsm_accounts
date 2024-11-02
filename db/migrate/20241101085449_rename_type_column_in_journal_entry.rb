class RenameTypeColumnInJournalEntry < ActiveRecord::Migration[8.0]
  def change
    rename_column :journal_entries, :type, :entry_type
  end
end
