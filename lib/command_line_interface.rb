require "./api_communicator.rb"

def welcome
  puts "Welcome!"
end

def get_character_from_user
  puts "please enter a character from the movie Star Wars"
  gets.chomp
  #trying to take all user_inputs regardless of format
  ##.split.collect { |word| word.capitalize }.join(" ")
end

def run
  welcome
  input=get_character_from_user
  puts "#{input} appears in the following movies:"
  show_character_movies(input)
end

run
