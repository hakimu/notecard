class Note < ApplicationRecord
  # belongs_to :quiz
  belongs_to :user
  validates :method, presence: true, if: Proc.new {|n| n.term.blank?}
  validates :term, presence: true, if: Proc.new {|n| n.method.blank?}
end
