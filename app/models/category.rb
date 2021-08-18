class Category < ApplicationRecord
  validates :title,
    presence: true, uniqueness: true
  validates :description,
    presence: true, length: { in: 10..100 }

  belongs_to :user
  has_many :tasks, dependent: :destroy
end
