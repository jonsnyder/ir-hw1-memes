
namespace :index do
  desc "load the documents into the database"
  task :load_docs => :environment do
    puts "Loading the Documents"
    puts "============================================"
    ActiveRecord::Base.transaction do    
      File.open( Rails.root.join( 'lib/data/url_title_pairs')).each_line do |line|
        url, title = line.split("\t")
        puts title
        content = File.open(Rails.root.join( 'lib/data', url + ".html")).read
        url = "http://en.wikipedia.org/wiki/" + url
        Document.create( :url => url, :title => title, :content => content)
      end
    end
  end

  task :index_docs => :environment do
    puts "Indexing the Documents"
    puts "============================================"
    File.open( Rails.root.join( 'lib/data/url_title_pairs')).each_line do |line|
      ActiveRecord::Base.transaction do
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
  end

  task :term_freq => :environment do
    puts "Calculating Term Frequencies"
    puts "============================================"
    Posting.all.each do |p|
      p.term_freq = p.positions.count
      p.save!
    end
  end

  task :freq => :environment do
    puts "Calculating Frequencies and Document Frequencies"
    puts "============================================"
    Term.all.each do |t|
      t.freq = t.postings.sum('term_freq')
      t.doc_freq = t.postings.count
      t.save!
    end
  end

  task :stopwords => :environment do
    puts "Removing 20 stopwords"
    puts "============================================"
    Term.order("doc_freq DESC").limit(20).each do |term|
      puts term.term
      term.stopword = true
    end
  end

  desc 'This builds the index from scratch'
  task :build => ["index:load_docs", "index:index_docs", "index:term_freq", "index:freq", "index:stopwords"]
  
end
