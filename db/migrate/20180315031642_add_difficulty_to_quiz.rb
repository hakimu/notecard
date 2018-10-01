class AddDifficultyToQuiz < ActiveRecord::Migration[5.1]
  def change
    add_column :quizzes, :difficulty, :integer
  end
end
