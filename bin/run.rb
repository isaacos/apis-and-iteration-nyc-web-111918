#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"



welcome
puts "Would you like to search for character or film?"
input = gets.chomp
if input == "film"
  puts "Please enter a film name"
  film = gets.chomp
  get_film_from_api(film)
elsif input == "character"
  
  character = get_character_from_user
  show_character_movies(character)
end
