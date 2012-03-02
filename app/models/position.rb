class Position < ActiveRecord::Base
  belongs_to :posting

  def snippet( content)

    score = posting.term_freq *
      Math::log(Document.count.to_f / posting.term.doc_freq)
    
    line_start = content.rindex( "\n", offset)
    line_start = line_start.nil? ? 0 : line_start + 1
    line_end = content.index("\n", offset + length)
    line_end = line_end.nil? ? content.length : line_end

    snippet_start = offset - 25
    snippet_start = 0 if snippet_start < 0
    snippet_start = content.rindex( " ", snippet_start)
    snippet_start = snippet_start.nil? ? 0 : snippet_start + 1

    snippet_end = offset + length + 25
    snippet_end = content.length if snippet_end >= content.length
    snippet_end = content.index( " ", snippet_end) 
    snippet_end = snippet_end.nil? ? content.length : snippet_end
    
    snippet_start = [snippet_start, line_start].max
    snippet_end = [snippet_end, line_end].min
    snippet_length = snippet_end - snippet_start
    
    snippet_text = content.slice( snippet_start, snippet_length)

    snippet = Snippet.new( snippet_text, snippet_start, snippet_length, score)
    snippet.highlight( offset, length)
    return snippet
  end
end
