def welcome
  # puts out a welcome message here!
  puts "I am groot. Welcome to the Great Star Trekky War town character finder app, friend!"
end

def get_character_from_user
  puts "please enter a character name"
   gets.chomp.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
