# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Omelete::DetailedPage, :vcr do
  
  before(:each) do
    @agent = Mechanize.new {|agent| agent.user_agent_alias = 'Mac Safari'}
    @agent.get("http://omelete.uol.com.br/filmes-em-cartaz?uf=SP&cidade=Santos"){ |page| @page = page }
    @movie = Omelete::Movie.new("3962","Battleship: A Batalha dos Mares")    
  end
  
  class MoviePageTest
    include Omelete
  end
  
  subject { @client = Omelete::DetailedPage.new(@page,"/filmes-em-cartaz/filme/3962/?cidade=Santos&uf=SP") }
  
  it "should not have a nil page object" do
    @page.should_not be_nil
  end
  
  it "should have on page, movie theater information" do
    movie_page = @page.link_with(:href => "/filmes-em-cartaz/filme/3962/?cidade=Santos&uf=SP").click
    movie_page.search('//div[@class = "programacao_cinema"]').should_not be_nil
  end
  
  it "should have on page, movie information" do
    @page.search('//div[@class = "programacao_filme"]').should_not be_nil
  end
  
  it "should return correct movie theaters" do    
    subject.movie_theaters(@movie).size.should > 1
    subject.movie_theaters(@movie).should include("Cinemark Praiamar Shopping")
  end
  
  it "should return correct movie synopsis" do
    subject.synopsis(@movie).should_not be_nil
    subject.synopsis(@movie).should eq("Uma frota naval enfrenta navios desconhecidos em alto mar.")
  end
  
  it "should return correct movie cast" do
    subject.cast(@movie).should_not be_nil
    subject.cast(@movie).should eq("Alexander Skarsgård,Liam Neeson,Brooklyn Decker,Taylor Kitsch,Josh Pence,Rihanna,Jesse Plemons,Peter MacNicol")
  end
  
  it "should return correct movie directed by" do
    subject.directed_by(@movie).should_not be_nil
    subject.directed_by(@movie).should eq("Peter Berg")
  end
  
  # it "should return correct showtimes" do
  #   subject.showtimes(@movie).size.should > 1
  #   st = Omelete::Showtime.new("", obs, kind, movie, theater, movie_theater)
  #   subject.showtimes(@movie).should include("Cinemark Praiamar Shopping")
  # end
  
end