class Statement < ApplicationRecord
  belongs_to :user
  has_one_attached :statement

  validates :start_date, :end_date, :statement, :uploaded_at, presence: true
end
