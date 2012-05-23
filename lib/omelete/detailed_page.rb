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
      mt = ""
      obs = ""
      @page.parser.xpath('//div[@id="content-left"]/div[@class="grid_8"]').children.each_with_index do |div_child|
        if div_child.name == "div"
          mt = div_child.search('h2').first.text.gsub("\n", "").strip if div_child.attribute("class").value == "programacao_cinema"          
          if div_child.attribute("class").value == "programacao_horarios"
            div_child.search('tr').each do |tr_doc|
              unless tr_doc.content.include?("Sala")
                obs = div_child.search('td[@colspan="3"]').first.content if div_child.search('td[@colspan="3"]').first
                sat = ShowtimeAndTheater.new tr_doc
                showtimes << sat.create_showtime_with(mt,movie,obs)
              end
            end
          end
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
      unless @doc.search('td').first.next_element.nil?
        showtime = Showtime.new(nil,nil,nil,movie,nil,movie_theater)
        showtime.time = time
        showtime.theater = theater
        showtime.kind = kind
        showtime.obs = observ
        # p "#{showtime.movie_theater} - #{showtime.theater} - #{showtime.movie.name} - #{showtime.time} - #{showtime.obs}"
      end
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