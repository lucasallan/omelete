# encoding: utf-8 
require 'spec_helper'

describe MainPage do
  
  class ClientTest 
    include MainPage
  end

  before(:each) do
    @page ||= Nokogiri::HTML(File.read("spec/fixtures/movies.html"))
    mock_uri = URI.parse(URI.encode("http://www.google.com/movies?near=Joao%20Pessoa".strip))
    ClientTest.any_instance.should_receive(:page_doc).with(mock_uri).and_return(@page)
  end

	subject { @client = ClientTest.new }

  it "should return one movie theater" do
    subject.movies_theaters("http://www.google.com/movies?near=Joao%20Pessoa").size.should == 1
  end
  
end