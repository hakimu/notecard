require 'rails_helper'

RSpec.describe Note, type: :model do
  describe '#create' do
		context 'when given valid attributes' do
      it 'is valid when ONLY a method is defined' do
        note = create(:note, term: nil)
        expect(note).to be_valid
      end
      it 'is valid when ONLY a term is defined' do
        note = create(:note, method: nil, term: 'duck typing')
        expect(note).to be_valid
      end
      it 'is valid when it has a "difficulty"' do
        note = create(:note, difficulty: 1)
        expect(note).to be_valid
      end
		end
    context 'when given INVALID attributes' do
      it 'is INVALID when there is not a "method" or "term"' do
        note = build(:note, method: nil, term: nil, difficulty: 1)
        note.save
        expect(note).to_not be_valid
        expect(note.errors.full_messages).to include('Method can\'t be blank')
        expect(note.errors.full_messages).to include('Term can\'t be blank')
      end
      it 'is INVALID when there is not a "difficulty"' do
        note = build(:note, difficulty: nil)
        note.save
        expect(note).to_not be_valid
        expect(note.errors.full_messages).to include('Difficulty must be between 1 and 5')
      end
      it 'is INVALID when a difficulty is not between 1 and 5' do
        low_note = build(:note, difficulty: 0)
        high_note = build(:note, difficulty: 6)
        low_note.save
        high_note.save
        expect(low_note).to_not be_valid
        expect(high_note).to_not be_valid
        expect(low_note.errors.full_messages).to include('Difficulty must be between 1 and 5')
        expect(high_note.errors.full_messages).to include('Difficulty must be between 1 and 5')
      end
    end
  end

  describe '#search' do
    context 'when given a valid search 'do
      it 'returns the matching "method" or "term" attribute' do
        note = create(:note, method: 'foo')
        another_note = create(:note, term: 'foo')
        expect(Note.search('foo')).to include(note, another_note)
      end
      it 'returns the proper notes with multiple notes' do
        create(:note, method: 'alias')
        create(:note, method: 'all?')
        create(:note, term: 'alias a method')
        random_note = create(:note, term: 'random note')
        expect(Note.search('al').count).to eq(3) 
        expect(Note.search('al')).to_not include(random_note)
      end
    end
    context 'when a match is found' do
      it 'returns notes that match the search critieria' do
        note_1 = build(:note, term: "pair programming", difficulty: 1)
        note_2 = build(:note, term: "mob programming", difficulty: 1)
        note_3 = build(:note, term: "bike shedding", difficulty: 1)
        note_1.save
        note_2.save
        note_3.save
        expect(Note.search("prog")).to include(note_1,note_2)
        expect(Note.search("prog")).to_not include(note_3)
      end
    end
    context 'when a match is not found' do
      it 'returns an empty response when there is not a match' do
        note_1 = build(:note, term: "pair programming", difficulty: 1)
        note_2 = build(:note, term: "mob programming", difficulty: 1)
        note_3 = build(:note, term: "bike shedding", difficulty: 1)
        note_1.save
        note_2.save
        note_3.save
        expect(Note.search("random")).to be_empty
      end
    end
  end
end
