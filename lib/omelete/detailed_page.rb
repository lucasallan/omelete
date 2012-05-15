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
    
    def initialize(page,link)
      @page = page.link_with(:href => link).click
    end
    
    def movie_poi(movie)
      movie.movie_theaters = movie_theaters(movie) unless @page.search('//div[@class = "programacao_cinema"]').first.nil?
      movie.showtimes = showtimes(movie) unless @page.search('//div[@class = "programacao_cinema"]').first.nil?
      movie.synopsis = synopsis(movie) unless @page.search("//div[@id = \"tab_#{movie.id}_sinopse\"]/blockquote").first.nil?
      unless @page.search("//div[@id = \"tab_#{movie.id}_ficha\"]/dl/dd").first.nil?
        movie.cast = cast(movie)
        movie.directed_by = directed_by(movie)
      end
      movie
    end
  
    def synopsis(movie)
      @page.search("//div[@id = \"tab_#{movie.id}_sinopse\"]/blockquote").first.content
    end
  
    def cast(movie)
      @page.search("//div[@id = \"tab_#{movie.id}_ficha\"]/dl/dd").first.content.delete("\r\n")
    end
  
    def directed_by(movie)    
      directed_by = ""
      @page.search("//div[@id = \"tab_#{movie.id}_ficha\"]/dl").first.children.each do |child|
        directed_by = child.content if child.node_name == "dd" && child.previous_element && child.previous_element.content == "Direção:"
      end
      directed_by.delete("\r\n")
    end
    
    def movie_theaters(movie)
      movie_theaters = []
      @page.search('//div[@class = "programacao_cinema"]/h2/a').each do |movie_theater|
        movie_theaters << movie_theater.content if movie_theater
      end
      movie_theaters
    end
  
    def showtimes(movie)
      showtimes = []
      movie_theaters=[]
      obs=[]
      @page.search('//div[@class = "programacao_cinema"]').each do |movie_theater_doc|
        movie_theater = movie_theater_doc.search('h2').first.search('a').first
        movie_theaters << movie_theater.content
      end
      
      @page.parser.xpath('//div[@class="programacao_horarios"]/table/tfoot/tr').each do |tfoot_tr_doc|        
        obs << tfoot_tr_doc.content.strip.delete("\n")
      end
      
      i = 0
      mi = 0
      @page.parser.xpath('//div[@class="programacao_horarios"]/table/tr').each do |tr_doc|
        unless tr_doc.content.include?("Sala")
          mi += 1 if i > 0 && i.even?
          mt = movie_theaters.at(mi)
          observ = obs.at(mi)
          sat = ShowtimeAndTheater.new tr_doc
          showtimes << sat.create_showtime_with(mt,movie,observ)
          i += 1
        end
      end
      
      showtimes
    end
    
  end

  class ShowtimeAndTheater
    
    def initialize(doc)      
      @doc = doc
    end
    
    def create_showtime_with(movie_theater,movie,observ)      
      showtime = Showtime.new(nil,nil,nil,movie,nil,movie_theater)
      showtime.time = time
      showtime.theater = theater
      showtime.kind = kind
      showtime.obs = observ
      showtime
    end
    
    def time
      @doc.search('td').last.content
    end
  
    def kind
      @doc.search('td').first.next_element.content
    end
  
    def theater
      @doc.search('td').first.content
    end
  
  end
end