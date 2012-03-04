class Posting < ActiveRecord::Base
  belongs_to :document
  belongs_to :term

  has_many :positions, :dependent => :destroy

end
