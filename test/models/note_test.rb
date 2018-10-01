require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  test "Rails should not save a newly created note" do
    note = Note.new
    note.save
    assert note.invalid?
  end

  test "Rails should not save a new note that doesn't have a 'method' or 'term' attribute present" do
    note = Note.new
    note.code_sample = "puts 'Hello World'"
    note.language = "Ruby"
    note.save
    refute note.valid?
  end

end
