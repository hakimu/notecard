class Quiz < ApplicationRecord
  DIFFICULTY = [1,2,3,4,5]
  has_many :notes
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :notes, presence: true

  def average_difficulty
    self.notes.average(:difficulty).to_i
  end
end
