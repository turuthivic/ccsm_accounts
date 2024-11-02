class JournalEntry < ApplicationRecord
  belongs_to :statement

  enum :entry_type, { credit: 1, debit: 2 }
end
