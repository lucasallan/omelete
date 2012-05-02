class Movie

  attr_accessor :id, :name, :status, :runtime, :cast, :genre, :directed_by, :release_date, :age_rating, :kind, :synopsis, :image

  def initialize(id, name, status, runtime, cast, genre, directed_by, release_date, age_rating, kind, synopsis, image)
    @id = id
    @name = name
    @status = status
    @runtime = runtime
    @cast = cast
    @genre = genre
    @directed_by = directed_by
    @release_date = release_date
    @age_rating = age_rating
    @kind = kind			
		@synopsis = synopsis
		@image = image
  end
end