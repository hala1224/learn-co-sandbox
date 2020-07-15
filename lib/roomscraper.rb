class RoomScraper
  
  def initialize(index_url)
    @doc = Nokogiri::HTML(open(index_url))
    binding.pry 
  end
    
  def scrape_time
    @doc.search("time.result date")
  end
end