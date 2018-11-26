require 'rails_helper'

RSpec.describe Note, type: :model do
  it "is valid when a method is defined" do
    user = User.create(username: "hakimu",password: "password")
    note = Note.new(method: "puts", user_id: 1)
    expect(note).to be_valid
  end
end
