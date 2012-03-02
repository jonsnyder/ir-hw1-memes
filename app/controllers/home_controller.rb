class HomeController < ApplicationController
  def index

    query = params[:q]
    if query

      doc_scores = {}
      doc_scores.default = 0
      doc_postings = {}
      doc_count = Document.count
      Tokenizer.scan( query) do |word|
        t = Term.find_by_term( word)
        if t
          idf = Math::log(doc_count.to_f / t.doc_freq)
          t.postings.each do |posting|
            doc_scores[posting.document_id] += posting.term_freq * idf
            (doc_postings[posting.document_id] ||= []) << posting
          end
        end
      end
      
      results = doc_scores.sort_by { |k,v| v}.reverse.take(10)
      @documents = results.map do |(document_id, score)|
        document = Document.find( document_id)
        snippets = []
        
        Position.where( :posting_id => doc_postings[document_id].map(&:id)).order('`offset`').take(100).each do |position|
          snippet = position.snippet( document.content)
          if snippets.count > 0 && snippets.last && snippets.last.overlaps( snippet)
            snippets[snippets.length-1] = snippets.last.combine( snippet)
          else
            snippets << snippet
          end
        end
        
        snippets = (snippets.sort_by { |snippet| -1 * snippet.score }).take(10).sort_by { |snippet| snippet.start }
        
        {:document => document, :score => score, :snippets => snippets}
      end
    else
      @documents = []
    end
  end
end
