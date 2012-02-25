class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
