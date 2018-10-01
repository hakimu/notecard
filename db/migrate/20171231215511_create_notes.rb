class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :method
      t.string :term
      t.text :code_sample
      t.text :definition
      t.text :language
      t.text :concept
      t.integer :difficulty

      t.timestamps
    end
  end
end
