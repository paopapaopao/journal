class Category < ApplicationRecord
  validates :title,
    presence: true, uniqueness: true
  validates :description,
    presence: true, length: { in: 10..100 }

  belongs_to :user
  has_many :tasks, dependent: :destroy

  scope :filtered, ->(query_params) { Category::Filter.new.filter(self, query_params) }
end
