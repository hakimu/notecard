class Note < ApplicationRecord
  DIFFICULTY = [1,2,3,4,5]
  belongs_to :user
  validates :method, presence: true, if: Proc.new { |n| n.term.blank? }
  validates :term, presence: true, if: Proc.new { |n| n.method.blank? }
  validates :difficulty, inclusion: {
    in: DIFFICULTY,
    message: 'must be between 1 and 5'
  }
  scope :method_or_term, ->(search_term) {
    where("LOWER(method) LIKE ? OR LOWER(term) LIKE ?","%#{search_term.downcase}%", "%#{search_term.downcase}%")
  }
end
