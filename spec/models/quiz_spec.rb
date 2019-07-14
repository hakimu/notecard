require 'rails_helper'

RSpec.describe Quiz, type: :model do
  context 'when given valid attributes' do
    it 'creates a valid quiz' do
      quiz = build(:quiz)
      expect { quiz.save }.to change { Quiz.count }.by(1)
    end
  end
end
