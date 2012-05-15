# -*- encoding : utf-8 -*-
#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require File.expand_path('../omelete/movie_page', __FILE__)


module Omelete
  class Client
    
    def initialize(state,city)
      @state=state
      @city=city
      @movie_page = MoviePage.new(@state,@city)
    end
    
    def movies
      @movie_page.movies if @movie_page
    end

  end
end