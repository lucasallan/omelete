# -*- encoding : utf-8 -*-
module Omelete
  class Movie

    attr_accessor :id, :name, :status, :runtime, :cast, :genre, :directed_by, :city, :state
    attr_accessor :age_rating, :synopsis, :image, :movie_theaters, :showtimes
  
    def initialize(id, name)
      @id = id
      @name = name
    end
  end
end