class AddStopwordToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :stopword, :boolean, :default => false
  end
end
