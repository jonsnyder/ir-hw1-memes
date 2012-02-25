class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.references :document
      t.references :term
      t.integer :term_freq

      t.timestamps
    end
    add_index :postings, :document_id
    add_index :postings, :term_id
  end
end
