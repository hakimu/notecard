require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe '#create' do
    let(:note) { create(:note) }
    let(:quiz) { build(:quiz) }
    context 'when given valid attributes' do
      it 'creates a valid quiz when given notes' do
        quiz.notes << note
        expect { quiz.save }.to change { Quiz.count }.by(1)
      end
      it 'calculates difficulty based on Note difficulty' do
       easy_note = create(:note, term: 'easy term', difficulty: 1)
       medium_note = create(:note, term: 'medium term', difficulty: 3)
       hard_note = create(:note, term: 'hard term', difficulty: 5)
       quiz.notes << easy_note
       quiz.notes << medium_note
       quiz.notes << hard_note
       quiz.save
       expect(quiz.average_difficulty).to eq(3)
      end
    end
    context 'when given invalid attributes' do
      it 'is invalid without a name' do
        quiz = build(:quiz, name: nil)
        quiz.notes << note
        quiz.save
        expect(quiz).to_not be_valid
        expect(quiz.errors.full_messages).to include('Name can\'t be blank')
      end
      it 'is invalid when the quiz name is not unique' do
        quiz.notes << note
        quiz.save
        another_quiz = build(:quiz, name: 'My Quiz')
        another_quiz.notes << note
        another_quiz.save
        expect(another_quiz.errors.full_messages).to include('Name has already been taken')
      end
      it 'is invalid without a note' do
        quiz.save
        expect(quiz.errors.full_messages).to include('Notes can\'t be blank')
      end
      it 'is invalid without a user' do
        quiz = build(:quiz, user_id: nil)
        quiz.notes << note
        quiz.save
        expect(quiz.errors.full_messages).to include('User must exist')
      end
    end
  end
end
