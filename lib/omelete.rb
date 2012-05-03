# encoding: utf-8 
require 'nokogiri'
require 'open-uri'


module Omelete
  
  class Client        
    
    def initialize(state,city)
      @state=state
      @city=city      
      @http_client = Omelete::MainPage.new(state,city)
    end
    
    def movies
      @http_client.movies
    end
    
  end
end