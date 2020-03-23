require 'rails_helper'

describe QuizFormatter do
  it 'formats the json' do
    note = create(:note)
    quiz = build(:quiz)
    quiz.notes << note
    quiz.save
    response = QuizFormatter.new(quiz.id).call
    json = { quiz: { "id": quiz.id, "nanme": quiz.name }, notes: [] }.to_json
    expect(response).to eq(json)
  end
end
