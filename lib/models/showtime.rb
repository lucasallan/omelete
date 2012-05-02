class Showtime

  attr_accessor :time, :obs, :movie, :theater

  def initialize(time, obs, movie, theater, movie_theater)
    @time = time
    @obs = obs
    @movie = movie
    @theater = theater
    @movie_theater = movie_theater
  end
end