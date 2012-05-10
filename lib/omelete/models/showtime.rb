# -*- encoding : utf-8 -*-
module Omelete
  class Showtime

    attr_accessor :time, :obs, :movie, :theater, :kind

    def initialize(time, obs, kind, movie, theater, movie_theater)
      @time = time
      @obs = obs
      @kind = kind
      @movie = movie
      @theater = theater
      @movie_theater = movie_theater
    end
  end
end