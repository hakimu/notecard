class AddQuestionsToQuiz < ActiveRecord::Migration[5.1]
  def change
    add_column :quizzes, :questions, :integer
  end
end
