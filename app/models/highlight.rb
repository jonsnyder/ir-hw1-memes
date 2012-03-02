class Highlight

  def initialize( offset) 
    @offset = offset
  end

  def <=>(other)
    offset <=> other.offset
  end
  
  attr_reader :offset
end
