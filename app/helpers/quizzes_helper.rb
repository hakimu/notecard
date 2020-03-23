module QuizzesHelper
  def notes_in_quizzes_attributes(note)
    note.attributes.keys.reject { |attribute| attribute =~ /id/ }
      .reject { |attribute| attribute =~ /_at/ }
  end 
end
