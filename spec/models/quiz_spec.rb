require 'rails_helper'

RSpec.describe Quiz, type: :model do
  context 'when given valid attributes' do
    it 'creates a valid quiz when given notes' do
      note = create(:note)
      quiz = build(:quiz)
      quiz.notes << note
      expect { quiz.save }.to change { Quiz.count }.by(1)
    end
  end
  context 'when given invalid attributes' do
    it 'is invalid without a name' do
      note = create(:note)
      quiz = build(:quiz, name: nil)
      quiz.notes << note
      quiz.save
      expect(quiz).to_not be_valid
      expect(quiz.errors.full_messages).to include('Name can\'t be blank')     
    end
    it 'is invalid when the quiz name is not unique' do
      note = create(:note)      
      quiz = build(:quiz)
      quiz.notes << note
      quiz.save
      another_quiz = build(:quiz, name: 'My Quiz')
      another_quiz.notes << note 
      another_quiz.save
      expect(another_quiz.errors.full_messages).to include('Name has already been taken')
    end
    it 'is invalid without a note' do
      quiz = build(:quiz)
      quiz.save
      expect(quiz.errors.full_messages).to include('Notes can\'t be blank')
    end
    it 'is invalid without a user' do
      note = create(:note)
      quiz = build(:quiz, user_id: nil)
      quiz.notes << note
      quiz.save
      expect(quiz.errors.full_messages).to include('User must exist')
    end
    it 'is invalid when there is not a difficulty' do
      note = create(:note)
      quiz = build(:quiz, difficulty: nil)
      quiz.notes << note
      quiz.save
      expect(quiz.errors.full_messages).to include('Difficulty must be between 1 and 5')
    end
    it 'is invalid when the difficulty is not between 1 and 5' do
      note = create(:note)
      low_quiz = build(:quiz, difficulty: 0)
      high_quiz = build(:quiz, difficulty: 6)
      low_quiz.notes << note
      high_quiz.notes << note
      low_quiz.save
      high_quiz.save
      expect(low_quiz).to_not be_valid
      expect(low_quiz.errors.full_messages).to include('Difficulty must be between 1 and 5')
      expect(high_quiz).to_not be_valid
      expect(high_quiz.errors.full_messages).to include('Difficulty must be between 1 and 5')
    end
  end
end
