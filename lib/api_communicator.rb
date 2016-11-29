require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(characters = nil)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`  character is in films xyz
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

if characters.nil?
  #----  all characters
  films = []
  character_hash["results"].each do |character_info|
    character_info["films"].each do |film|
      films << film
      end
    end
    film_list = films.flatten.uniq!.sort!
else
  #individual character only
    films = []
    character_hash["results"].each do |character_info|
      if character_info["name"] == characters
        films.push(character_info["films"])
      end
    end
    film_list = films.flatten.sort!
  end
#processing either film list
film_descriptions = {}
film_list.each do |film|
   description = RestClient.get(film)
   description_hash = JSON.parse(description)
   film_descriptions[film] = description_hash
 end
film_descriptions
end

def parse_character_movies(film_descriptions)
  # some iteration magic and puts out the movies in a nice list
  roman_numerals = ["I", "II", "III", "IV", "V", "VI", "VII"]
  film_descriptions.each do |link, description_hash|
    puts "Star Wars: Episode #{roman_numerals[description_hash["episode_id"]-1]} - #{description_hash["title"]} "
    puts "Directed by #{description_hash["director"]}"
    puts "Released on #{description_hash["release_date"]}"
    puts " "
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end


def run
  welcome
  puts get_character_from_user
end



## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
