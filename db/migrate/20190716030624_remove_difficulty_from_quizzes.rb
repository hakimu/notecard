class RemoveDifficultyFromQuizzes < ActiveRecord::Migration[5.1]
  def change
    remove_column :quizzes, :difficulty, :integer
  end
end
