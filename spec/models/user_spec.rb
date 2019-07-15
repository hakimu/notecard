require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'when given valid attributes' do
      it 'creates a valid User with a username, email and password' do
        user = create(:user)
        expect(user).to be_valid
      end
      it 'is able to have a note associated with it' do
        user = create(:user)
        user.notes.create(method: 'def', code_sample: 'def test_method end', difficulty: 1)
        expect(user.notes.count).to eq(1)
      end
      it 'is able to have multiple notes associated with it' do
        user = create(:user)
        create(:note, user_id: user.id)  
        create(:note, user_id: user.id)
        expect(user.notes.count).to eq(2)
      end
    end
    context 'when given INVALID attributes' do
      it 'is invalid without a username' do
        user = build(:user, username: nil)
        user.save
        expect(user.errors[:username]).to include('can\'t be blank')
      end
      it 'is invalid without an email' do
        user = build(:user, email: nil)
        user.save
        expect(user.errors[:email]).to include('can\'t be blank', 'is invalid')
      end
			it 'is invalid with an invalid email address' do
				user = build(:user, email: 'h@')
				user.valid?
				expect(user.errors.full_messages).to include('Email is invalid')
			end
			it 'is invalid with a duplicate username' do
				create(:user, username: 'hakimu')
				another_user = FactoryBot.build(:user, username: 'hakimu')
				another_user.valid?
				expect(another_user.errors[:username]).to include('has already been taken')
			end
      it 'is invalid with a duplicate email' do
        create(:user, email: 'h@example.com')
        another_user = FactoryBot.build(:user, email: 'h@example.com')
        another_user.valid?
        expect(another_user.errors[:email]).to include('has already been taken')
      end
			it 'is invalid with a password less than 6 characters' do
				user = FactoryBot.build(:user, password: 'pass')
				user.valid?
				expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
			end
    end
  end
end
