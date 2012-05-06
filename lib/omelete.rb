# encoding: utf-8 
require 'nokogiri'
require 'open-uri'


module Omelete
  
  class Client
    
    def initialize(state,city)
      @state=state
      @city=city      
      @main_page = MainPage.new(state,city)
    end
    
    def movies
      @main_page.movies
    end
    
  end
end