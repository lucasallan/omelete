# -*- encoding : utf-8 -*-
#!/usr/bin/env ruby
$:.unshift File.expand_path('../models', __FILE__)
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'movie'
require 'showtime'

module Omelete
  class DetailedPage

    def self.movie_poi(movie,link,page)    
      @page = page.link_with(:href => link).click
      movie.movie_theaters = movie_theaters(movie) unless @page.search('//div[@class = "programacao_cinema"]').first.nil?
      movie.showtimes = showtimes(movie) unless @page.search('//div[@class = "programacao_cinema"]').first.nil?
      movie.synopsis = synopsis(movie) unless @page.search("//div[@id = \"tab_#{movie.id}_sinopse\"]/blockquote").first.nil?    
      unless @page.search("//div[@id = \"tab_#{movie.id}_ficha\"]/dl/dd").first.nil?
        movie.cast = cast(movie)
        movie.directed_by = directed_by(movie)
      end
      movie
    end

    def self.movie_theaters(movie)
      movie_theaters = []
      @page.search('//div[@class = "programacao_cinema"]/h2/a').each do |movie_theater|
        movie_theaters << movie_theater.content      
      end
      movie_theaters
    end
  
    def self.showtimes(movie)
      showtimes = []
      @page.search('//div[@class = "programacao_cinema"]/h2/a').each do |movie_theater|      
        showtimes << ShowtimeAndTheater.create_showtime_with(@page,movie_theater.content,movie)
      end
      showtimes
    end
  
  
    def self.synopsis(movie)
      @page.search("//div[@id = \"tab_#{movie.id}_sinopse\"]/blockquote").first.content
    end
  
    def self.cast(movie)
      @page.search("//div[@id = \"tab_#{movie.id}_ficha\"]/dl/dd").first.content.delete("\r\n")
    end
  
    def self.directed_by(movie)    
      directed_by = ""
      @page.search("//div[@id = \"tab_#{movie.id}_ficha\"]/dl").first.children.each do |child|
        directed_by = child.content if child.node_name == "dd" && child.previous_element && child.previous_element.content == "Direção:"
      end
      directed_by.delete("\r\n")
    end
  
  end

  class ShowtimeAndTheater
    def self.create_showtime_with(page,movie_theater,movie)
      @page = page
      showtime = Showtime.new(nil,nil,nil,movie,nil,movie_theater)
      showtime.time = time
      showtime.theater = theater
      showtime.kind = kind
      showtime.obs = obs
      showtime
    end
  
    def self.time
      @page.search('//tr[@class = "even"]/td').last.content
    end
  
    def self.kind
      @page.search('//tr[@class = "even"]/td').first.next_element.content
    end
  
    def self.theater
      @page.search('//tr[@class = "even"]/td').first.content
    end
  
    def self.obs
      @page.search('//td[@colspan = "3"]').first.content if @page.search('//td[@colspan = "3"]').first
    end
  
  end
end