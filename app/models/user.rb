class User < ApplicationRecord
  has_secure_password
  has_many :notes
  has_many :quizzes
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i, :on => :create
  validates :password, length: { minimum: 6, maximum: 73}
end
