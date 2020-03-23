require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe QuizzesHelper, type: :helper do
  describe '#notes_in_quizzes_attributes' do
    it 'gets the attributes from a quiz\'s notes' do
      note = create(:note)
      expected = ['method', 'code_sample', 'difficulty', 'definition', 'language', 'term', 'concept'].sort
      expect(notes_in_quizzes_attributes(note).sort).to eq(expected)
    end
  end
end
