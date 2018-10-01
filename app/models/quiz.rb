class Quiz < ApplicationRecord
  has_many :notes
  validates :name, presence: true
  validates :notes, presence: true
  validates :questions, presence: true
end
