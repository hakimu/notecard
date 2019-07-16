require 'json'

class QuizFormatter
  def initialize(quiz_id)
    @quiz_id = quiz_id
  end

  def call
    notes = find_quiz.notes.to_json
    quiz = find_quiz.to_json
    quiz + notes 
  end

  private

  def find_quiz
    @quiz ||= Quiz.find(@quiz_id)
  end
end
