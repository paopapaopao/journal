class Task < ApplicationRecord
  validates :description,
    presence: true, length: { in: 10..100 }

  belongs_to :category
end
