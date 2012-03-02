class Snippet

  def initialize( text, start, length, score) 
    @text = text
    @start = start
    @length = length
    @highlights = []
    @score = score
  end

  def highlight( start, length)
    @highlights << HighlightStart.new( start)
    @highlights << HighlightEnd.new( start + length)
  end

  def overlaps( other)
    (start <= other.end_offset && other.start <= end_offset)
  end

  def combine( other)
    
    starts_first = start < other.start ? self : other
    ends_last = end_offset > other.end_offset ? self : other
    
    if starts_first == ends_last
      new_text = starts_first.text
    else
      new_text = starts_first.text.slice(0, ends_last.start - starts_first.start) + ends_last.text
    end
    
    new_snippet = Snippet.new( new_text, starts_first.start, ends_last.end_offset - starts_first.start, score + other.score)
    new_snippet.highlights = highlights + other.highlights
    
    return new_snippet
  end

  def to_html
    offset = start
    str = ""
    highlights.sort.each do |h|
      str << text.slice( offset - start, h.offset - offset)
      str << h.to_html
      offset = h.offset
    end
    str << text.slice( offset - start, end_offset - offset)
    return str.html_safe
  end
      
  attr_reader :text
  attr_reader :start
  attr_reader :length
  attr_reader :score
  attr :highlights, true

  def end_offset
    @start + @length
  end
end
