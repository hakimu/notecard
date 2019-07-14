class Quiz < ApplicationRecord
  DIFFICULTY = [1,2,3,4,5]
  has_many :notes
  belongs_to :user
  validates :name, presence: true
  validates :notes, presence: true
  validates :questions, presence: true
  validates :difficulty, inclusion: {
    in: DIFFICULTY,
    message: "must be between 1 and 5"
  }
end
