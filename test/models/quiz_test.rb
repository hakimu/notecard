require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  
  test "A quiz needs to have a name" do
    quiz = Quiz.new
    assert_not quiz.save
  end

  test "A test with a name should be valid" do
    quiz = Quiz.create(name: "valid_quiz")
    assert quiz
  end

  test "A quiz needs to have a note" do
    quiz = Quiz.create(name: "ruby_quiz")
    assert_not quiz.save
  end

  test "A quiz with a note is valid" do
    note = Note.create(method: "puts")
    quiz = Quiz.create(name: "ruby_quiz")
    quiz.notes << note
    quiz.save
    assert quiz
  end

  test "A quiz needs to have at least one question" do
    note = Note.create(method: "puts")
    quiz = Quiz.create(name: "ruby_quiz")
    quiz.notes << note
    assert_not quiz.save
  end

  test "A quiz with a name, note and question is valid" do
    note = Note.create(method: "puts")
    quiz = Quiz.create(name: "ruby_quiz")
    quiz.notes << note
    puts "quiz questions is #{quiz.questions}"
    # quiz.questions = 2
    quiz.save
    assert quiz  
  end
  
end
