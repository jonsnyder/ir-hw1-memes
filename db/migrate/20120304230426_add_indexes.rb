class AddIndexes < ActiveRecord::Migration
  def change
    add_index :positions, :offset, :order => {:offset => :desc}
    add_index :terms, :term, :unique => true
  end
end
