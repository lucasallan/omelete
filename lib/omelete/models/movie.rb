module Omelete
  class Movie

    attr_accessor :id, :name, :status, :runtime, :cast, :genre, :directed_by
    attr_accessor :age_rating, :synopsis, :image, :movie_theaters, :showtimes
  
    def initialize(id, name, status, runtime, cast, genre, directed_by, age_rating, synopsis, image, movie_theaters=[], showtimes=[])
      @id = id
      @name = name
      @status = status
      @runtime = runtime
      @cast = cast
      @genre = genre
      @directed_by = directed_by
      @age_rating = age_rating
  		@synopsis = synopsis
  		@image = image
  		@movie_theaters = movie_theaters
    end
  end
end