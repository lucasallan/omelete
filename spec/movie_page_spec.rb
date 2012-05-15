# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Omelete::MoviePage, :vcr do
  
  before(:each) do
    @agent = Mechanize.new {|agent| agent.user_agent_alias = 'Mac Safari'}
    @agent.get("http://omelete.uol.com.br/filmes-em-cartaz?uf=SP&cidade=Santos"){ |page| @page = page }
  end
  
  class MoviePageTest
    include Omelete
  end
  
  subject { @client = Omelete::MoviePage.new("SP", "São Paulo") }
  
  it "return movie id receiving a link" do
    subject.id_from("http://omelete.uol.com.br/filmes-em-cartaz/filme/3962/?cidade=Santos&uf=SP").should eq "3962"
  end
  
  it "should have on page, movie information" do
    @page.search('//div[@class = "programacao_filme"]').should_not be_nil
  end
  
end