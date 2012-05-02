# -*- encoding : utf-8 -*-
#!/usr/bin/env ruby
$:.unshift File.expand_path('../models', __FILE__)
require 'rubygems'
require 'movie'
require 'open-uri'
require 'nokogiri'
require 'mechanize'

class DetailedPage

  def self.movie_poi(movie,link,page)    
    poi_page = page.link_with(:href => link).click    
    movie.movie_theaters = get_movie_theaters(poi_page) unless poi_page.search('//div[@class = "programacao_cinema"]').first.nil?
    movie.synopsis = get_synopsis(movie.id)
    movie
  end

  def self.get_movie_theaters(page)
    movie_theaters = []
    page.search('//div[@class = "programacao_cinema"]/h2/a').each do |movie_theater|
      movie_theaters << movie_theater.content      
    end
    movie_theaters
  end

  def self.get_synopsis(id)
    "tab_#{id}_sinopse"
  end
  
end