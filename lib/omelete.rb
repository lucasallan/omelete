# encoding: utf-8 
#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require File.expand_path('../omelete/main_page', __FILE__)


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