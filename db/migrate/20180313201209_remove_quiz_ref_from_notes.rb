class RemoveQuizRefFromNotes < ActiveRecord::Migration[5.1]
  def change
    remove_reference :notes, :quiz, foreign_key: true
  end
end
