# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Omelete, :vcr do
  
  it "should create a client with the city and state and return movies count" do  
    @omelete = Omelete::Client.new('SP', 'Santos')
    @omelete.movies.count.should > 1
  end
  
end