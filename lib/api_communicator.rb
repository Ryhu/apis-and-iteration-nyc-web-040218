require_relative "../lib/command_line_interface.rb"
require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  chars_hash = character_hash["results"]
  chars_hash.each do |hash|
    hash.each do |att, val|
      # binding.pry
      if character == hash["name"].downcase
        return hash["films"]
      end
    end
  end
  nil
end
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


def parse_character_movies(films_hash)
  films_hash.each.with_index(1) do |movie, index|

    movie_info = RestClient.get(movie)
    movie_hash = JSON.parse(movie_info)
    movie_title = movie_hash["title"]
    puts "#{index}. #{movie_title}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if films_hash == nil
    bootleg_recursion
    return nil
  end

  parse_character_movies(films_hash)
end

def bootleg_recursion
  puts "Please enter a valid input..."
  character = get_character_from_user
  show_character_movies(character)
end





## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
