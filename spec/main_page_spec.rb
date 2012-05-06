# encoding: utf-8 
require 'spec_helper'

describe Omelete::MainPage do
  
  class MainPageTest
    include Omelete
  end
  
  subject { @client = Omelete::MainPage.new("SP", "São Paulo") }

  it "should return one movie" do
    VCR.use_cassette('main_page') do
      subject.movies.size.should > 1
    end
  end
  
end