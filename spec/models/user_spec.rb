require 'rails_helper'

# describe User do
#   it 'has a valid factory' do
#     expect(FactoryBot.build(:user)).to be_valid
#   end
# end

RSpec.describe User, type: :model do
  it 'valid with a username, email and password' do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a username' do
    user = FactoryBot.build(:user, username: nil) 
    user.valid?
    expect(user.errors[:username]).to include('can\'t be blank')
  end

  it 'is invalid without an email' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('can\'t be blank', 'is invalid')
  end

  it 'is invalid with a duplicate username' do
    FactoryBot.create(:user, username: 'hakimu')
    user = FactoryBot.build(:user, username: 'hakimu')
    user.valid?
    expect(user.errors[:username]).to include('has already been taken')
  end

  it 'is invalid with a duplicate email' do
    FactoryBot.create(:user, email: 'h@example.com')
    user = FactoryBot.build(:user, email: 'h@example.com')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end
  it 'is able to have a note associated with it' do
    user = FactoryBot.create(:user)
    note = user.notes.create(method: 'def', code_sample: 'def test_method end', difficulty: 1)
    expect(user.notes.count).to eq(1)
  end
  it 'is able to have multiple notes associated with it' do
    user = create(:user)
    note_1 = create(:note, user_id: user.id)  
    note_2 = create(:note, user_id: user.id)
    expect(user.notes.count).to eq(2)
  end

  it 'is invalid with an invalid email address' do
    user = FactoryBot.build(:user, email: 'h@')
    # user = User.create(username: 'hakimu', email: 'h@', password: 'password')
    user.valid?
    expect(user.errors.full_messages).to include('Email is invalid')
  end

  it 'is invalid with a password less than 6 characters' do
    user = FactoryBot.build(:user, password: 'pass')
    user.valid?
    expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
  end

end
