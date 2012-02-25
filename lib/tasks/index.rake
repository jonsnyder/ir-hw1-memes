
namespace :index do
  desc "load the documents into the database"
  task :load_docs => :environment do
    File.open( Rails.root.join( 'lib/data/url_title_pairs')).each_line do |line|
      url, title = line.split("\t")
      puts title
      content = File.open(Rails.root.join( 'lib/data', url + ".html")).read
      url = "http://en.wikipedia.org/wiki/" + url
      Document.create( :url => url, :title => title, :content => content)
    end
  end

  task :index_docs => :environment do
    File.open( Rails.root.join( 'lib/data/url_title_pairs')).each_line do |line|
      url, title = line.split("\t")
      puts title
      doc = Document.find_by_url( 'http://en.wikipedia.org/wiki/' + url)

      Tokenizer.scan(doc.content) do |word, start, length|

        term = Term.find_or_create_by_term( word)
        posting = Posting.find_or_create_by_term_id_and_document_id( term.id, doc.id)
        Position.create( :posting => posting, :offset => start, :length => length)
      end
    end
  end

  task :term_freq => :environment do
    term_frequencies = Position.select( "posting_id, count(id) as count").group("posting_id")
    term_frequencies.each do |tf|
      p = Posting.find( tf.posting_id)
      p.term_freq = tf.count
      p.save!
    end
  end

  task :doc_freq => :environment do
    doc_frequencies = Posting.select( "term_id, count(id) as count").group("term_id")
    doc_frequencies.each do |df|
      t = Term.find( df.term_id)
      t.doc_freq = df.count
      t.save!
    end
  end
end
