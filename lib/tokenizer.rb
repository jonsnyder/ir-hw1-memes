require 'fast_stemmer'

module Tokenizer

  def self.scan( content)

    content.scan(/[a-zA-Z0-9']+/) do |word|
      start = $~.offset(0)[0]
      length = $~.offset(0)[1] - start
      word = word.downcase
      word.gsub!(/'/) {""}
      
      yield Stemmer::stem_word( word), start, length
    end
  end
end
