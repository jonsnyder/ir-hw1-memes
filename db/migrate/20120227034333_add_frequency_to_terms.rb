class AddFrequencyToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :freq, :integer
  end
end
