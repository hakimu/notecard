require 'rails_helper'

RSpec.describe Note, type: :model do
  before do 
    # @user = User.create(username: 'hakimu', email: 'h@example.com', password: 'password')
    @user = FactoryBot.create(:user)
    @note = FactoryBot.create(:note)
    # @user.save
  end

  it 'test the helper' do
    expect(test_helper).to eq('bar')
  end

  it 'works' do
    puts "user is valid? #{@user.valid?}"
    note = @user.notes.build(:note)
    note.save
    expect(note).to be_valid
  end

  it 'is valid when a method is defined' do
    note = @user.notes.create(method: 'puts', difficulty: 1)
    expect(note).to be_valid
  end

  it 'is not valid when a method is not defined' do
    note = @user.notes.create(method: nil, difficulty: 1)
    expect(note.errors.full_messages).to include('Method can\'t be blank')
  end

  it 'is not valid when a term is not defined' do
    note = @user.notes.create(term: nil, difficulty: 1)
    expect(note.errors.full_messages).to include('Term can\'t be blank')
  end

  it 'is not valid when a difficulty is not defined' do
    note = @user.notes.create(method: 'puts')
    expect(note.errors.full_messages).to include('Difficulty must be between 1 and 5')
  end

  it 'is not valid when a difficulty is not between 1 and 5' do
    note = @user.notes.create(method: 'puts', difficulty: 0)
    expect(note.errors.full_messages).to include('Difficulty must be between 1 and 5')
  end

  it 'is not valid when a difficulty is not between 1 and 5' do
    note = @user.notes.create(method: 'puts', difficulty: 6)
    expect(note.errors.full_messages).to include('Difficulty must be between 1 and 5')
  end

  describe 'search for a term' do
    context 'when a match is found' do
      it 'returns notes that match the search critieria' do
        # user = FactoryBot.build(:user)
        note_1 = @user.notes.build(term: "pair programming", difficulty: 1)
        note_2 = @user.notes.build(term: "mob programming", difficulty: 1)
        note_3 = @user.notes.build(term: "bike shedding", difficulty: 1)
        note_1.save
        note_2.save
        note_3.save
        expect(Note.search("prog")).to include(note_1,note_2)
        expect(Note.search("prog")).to_not include(note_3)
      end
    end

    context 'when a match is not found' do
      it 'returns an empty response when there is not a match' do
        # user = FactoryBot.build(:user)
        note_1 = @user.notes.build(term: "pair programming", difficulty: 1)
        note_2 = @user.notes.build(term: "mob programming", difficulty: 1)
        note_3 = @user.notes.build(term: "bike shedding", difficulty: 1)
        note_1.save
        note_2.save
        note_3.save
        expect(Note.search("random")).to be_empty
      end
    end
  end

end
