# encoding: utf-8 
require 'spec_helper'

describe Omelete::MainPage do
  
  class MainPageTest
    include Omelete
  end
  
  before(:each) do
    # @page ||= Nokogiri::HTML(File.read("spec/fixtures/movies.html"))
    # mock_uri = URI.parse(URI.encode("http://omelete.uol.com.br/filmes-em-cartaz".strip))
    # ClientTest.any_instance.should_receive(:city,:state).with("SP", "São Paulo").and_return(@page)
  end
  
  subject { @client = Omelete::MainPage.new("SP", "São Paulo") }

  it "should return one movie" do
    subject.movies.size.should == 1
  end
  
end