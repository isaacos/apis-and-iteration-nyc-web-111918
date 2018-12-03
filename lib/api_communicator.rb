require 'rest-client'
require 'json'
require 'pry'


def get_film_from_api(film_title)
  response_string = RestClient.get('http://www.swapi.co/api/films/')
  response_hash = JSON.parse(response_string)
   films_array = response_hash["results"].find do |film_hash|
      film_hash["title"].downcase == film_title.downcase
   end
  print_movies([films_array])
end

def get_character_movies_from_api(character_name)
  #make the web request
  films_array = []
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  while films_array == []
    response_hash = JSON.parse(response_string)
    response_hash["results"].select do |character_hash|
       if character_hash["name"].downcase == character_name
           films_array.concat(character_hash["films"])
       end
     end
    # binding.pry
     if response_hash["next"].class == NilClass
       return "Character was not found"
     else
       response_string = RestClient.get(response_hash["next"])
     end
  end

   films_array.map do |film_url|
     JSON.parse(RestClient.get(film_url))
   end
  #  binding.pry
   # film_string = RestClient.get('http://www.swapi.co/api/films/')
   # film_hash = JSON.parse(film_string)


   # binding.pry
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  # method will do some nice presentation stuff like puts out a list
  # of movies by title. Have a play around with the puts with other info about a given film.
  films.select do |film|
    puts "Title: #{film["title"]} Episode #{film["episode_id"]}"
    puts "Intro: #{film["opening_crawl"][0...70].split("\r\n").join(" ")}" + "..."
    puts "Director: #{film["director"]}"
    puts "Release Date: #{film["release_date"].split("-").join("/")}"
    puts "************************************************"
    # binding.pry
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  if films == "Character was not found"
    puts "Character was not found"
    return
  end
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
