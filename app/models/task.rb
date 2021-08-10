class Task < ApplicationRecord
  validates :description,
    presence: true, length: { minimum: 10, maximum: 100 }

  belongs_to :category
end