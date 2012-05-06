# encoding: utf-8 
require 'spec_helper'

describe Omelete do
  
  it "should create a client with the city and state and return movies count" do  
    VCR.use_cassette('omelete') do      
      @omelete = Omelete::Client.new("SP", "São Paulo")
      @omelete.movies.count.should > 0
    end
  end
  
end