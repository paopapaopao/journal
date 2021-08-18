class Category < ApplicationRecord
  validates :title,
    presence: true, uniqueness: true
  validates :description,
    presence: true, length: { in: 10..100 }

  has_many :tasks, dependent: :destroy
end
