class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :term
      t.integer :doc_freq

      t.timestamps
    end
  end
end
