class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.references :posting
      t.integer :offset
      t.integer :length

      t.timestamps
    end
    add_index :positions, :posting_id
  end
end
