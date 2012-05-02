# -*- encoding : utf-8 -*-
#!/usr/bin/env ruby
$:.unshift File.expand_path('../', __FILE__)
$:.unshift File.expand_path('../models', __FILE__)
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'movie'
require 'detailed_page'

class MainPage
  #  Deve retornar um array de filmes, outro de salas e outro de horários
  URL = "http://omelete.uol.com.br/filmes-em-cartaz"
  
  def initialize(state,city)
    @state=state
    @city=city
    @agent = Mechanize.new {|agent| agent.user_agent_alias = 'Mac Safari'}
  end
  
  def crawl
    @movies = []
    @agent.get(URL + "?uf=#{@state}&cidade=#{@city}&filme=&filme_id=") do |page|
      page.search('//div[@style = "margin-right: 38%;"]/h2').each do |movie_status|
        movie_status.search('//div[@class = "programacao_filme"]').each do |movie_doc|
          status = movie_status.content.delete("\n").strip
          @movies << create_movie_with(movie_doc,status,page)          
          # puts "=================="
        end
      end
    end
  end
  
  def create_movie_with(movie_doc,status,page)
    name = movie_doc.search('h2').first.search('a').first.content.strip    
    info = movie_doc.search('h4').first.content.strip.split('-')
    genre = info[0]
    runtime = info[1]
    age_rating = info[2]
    link = movie_doc.search('p').first.search('a').first.attr('href')
    id = id_from(link)
    image = movie_doc.search('div').first.search('a').first.attr('href').strip unless movie_doc.search('div').first.search('a').first.nil?
    
    movie = Movie.new(id,name,status,runtime,'',genre,'', nil, age_rating, '', '', image)
    complete_movie = DetailedPage.movie_poi(movie,link,page)
  end
  
  def id_from(link)    
    link.match(/\d+/)[0]
  end
  
end

mp = MainPage.new('SP', 'São Paulo')
mp.crawl