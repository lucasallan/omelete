# -*- encoding : utf-8 -*-
#!/usr/bin/env ruby
$:.unshift File.expand_path('../models', __FILE__)
require 'rubygems'
require 'movie'
require 'open-uri'
require 'nokogiri'
require 'mechanize'

class Omelete
  #  Deve retornar um array de filmes, outro de salas e outro de horários
  URL = "http://omelete.uol.com.br/filmes-em-cartaz"
  
  def initialize(state,city)
    @state=state
    @city=city
    @agent = Mechanize.new {|agent| agent.user_agent_alias = 'Mac Safari'}
  end
  
  def crawling
    @movies = []
    @agent.get(URL + "?uf=#{@state}&cidade=#{@city}&filme=&filme_id=") do |page|
      page.search('//div[@class = "programacao_filme"]').each do |movie_doc|
        @movies << create_movie_with(movie_doc)
        puts "=================="
      end
    end
  end
  
  def create_movie_with(movie_doc)
    name = movie_doc.search('h2').first.search('a').first.content.strip
    info = movie_doc.search('h4').first.content.strip.split('-')
    genre = info[0]
    runtime = info[1]
    age_rating = info[2]
    image = movie_doc.search('div').first.search('a').first.attr('href').strip unless movie_doc.search('div').first.search('a').first.nil?
    movie = Movie.new(nil,name,nil,runtime,'',genre,'', nil, age_rating, '', '', image)
    complete_movie = get_poi(movie,movie_doc)
  end
  
  def get_poi(movie, movie_doc)
    movie_doc.search('p').first.search('a').first.attr('href').strip
    info_page = link.click
    info_page.search('//div[@id = "informacoes"]')
  end
  
end

b = Omelete.new('SP', 'São Paulo')
b.crawling