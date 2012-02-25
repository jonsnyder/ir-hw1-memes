
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
end
