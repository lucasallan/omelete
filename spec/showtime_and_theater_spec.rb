describe Omelete::ShowtimeAndTheater, :vcr do
  
  before(:each) do
    @agent = Mechanize.new {|agent| agent.user_agent_alias = 'Mac Safari'}
    @agent.get("http://omelete.uol.com.br/filmes-em-cartaz/filme/3962/?cidade=Santos&uf=SP"){ |page| @page = page }
    @movie = Omelete::Movie.new("3962","Battleship: A Batalha dos Mares")
    @last_tr_doc = @page.parser.xpath('//div[@class="programacao_horarios"]/table/tr').last
  end
  
  class MoviePageTest
    include Omelete
  end
  
  subject { @client = Omelete::ShowtimeAndTheater.new(@last_tr_doc) }
  
  it "should not have a nil page object" do
    @page.should_not be_nil
  end
  
  it "should has movie information" do
    @page.search('//div[@class = "programacao_cinema"]').first.should_not be_nil
  end
  
  it "should has showtime information" do
    @page.parser.xpath('//div[@class="programacao_horarios"]/table/tr').first.should_not be_nil
  end
  
  it "should return correct showtime time" do
    subject.time.should_not be_nil
    subject.time.should eq("15h00, 17h30, 20h00, 22h30")
  end
  
  it "should return correct showtime theater" do
    subject.theater.should_not be_nil
    subject.theater.should eq("2")
  end
  
  it "should return correct showtime kind" do
    subject.kind.should_not be_nil
    subject.kind.should eq("Leg.")
  end
  
end