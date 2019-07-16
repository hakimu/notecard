class RemoveQuestionFromQuizzes < ActiveRecord::Migration[5.1]
  def change
    remove_column :quizzes, :question, :integer
  end
end
