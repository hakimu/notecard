class AddQuizRefToNotes < ActiveRecord::Migration[5.1]
  def change
    add_reference :notes, :quiz, foreign_key: true
  end
end
