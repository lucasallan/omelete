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

module Omelete
  class MoviePage
    URL = "http://omelete.uol.com.br/filmes-em-cartaz"
    def initialize(state,city)
      @state = state
      @city = city
      @agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari'}
      url=URL + "?uf=#{@state}&cidade=#{@city}"
      @agent.get(URI.escape(url)){ |page| @page = page }
    end

    def movies      
      @movies = []
      @page.search('//div[@class = "programacao_filme"]').each do |movie_doc|
        link = movie_doc.search('p').first.search('a').first.attr('href')
        id = id_from(link)
        return @movies if movie_doc.search('h2').first.search('a').first.nil?
        name = movie_doc.search('h2').first.search('a').first.content.strip
        movie = Movie.new(id,name)
        
        return @movies if movie_doc.search('h4').first.nil?
        info = movie_doc.search('h4').first.content.strip.split('-')
        movie.genre = info[0]
        movie.runtime = info[1]
        movie.age_rating = info[2]        
        movie.image = movie_doc.search('div').first.search('a').first.attr('href').strip unless movie_doc.search('div').first.search('a').first.nil?
      
        dp = DetailedPage.new(@page, link)        
        @movies << dp.movie_poi(movie)
      end
      @movies
    end

    def id_from(link)
      link.match(/\d+/)[0]
    end

  end
end