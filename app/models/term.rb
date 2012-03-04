class Term < ActiveRecord::Base
  has_many :postings, :dependent => :destroy
end
