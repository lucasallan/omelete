# Omelete

Ruby web crawler to access omelete informations.
This gem returns some information about Brazilian's website Omelete's movies, like: runtime, cast, genre, the director, age_rating, synopsis, image, the movie_theaters, and showtimes.


## Installation

Add this line to your application's Gemfile:

    gem 'omelete'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omelete

## Usage

	client = Omelete::MainPage.new("SP", "São Paulo")

### Getting Movies information

	client.movies

### Observation
	
	I pretend to cover with more specs when I have some time to do it. By now the spec coverage is very poor.

## License

###(The MIT License)

Copyright (c) 2012 Mauricio Espinola Voto (milkonrails.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.