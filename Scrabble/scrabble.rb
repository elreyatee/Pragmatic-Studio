# Extra practice with blocks and hashes
#
# Suppose we wanted to simulate a game of Scrabble. In Scrabble, each letter
# has an associated point value and the score of a word is the sum of the points
# of all the letters in the word. In our abbreviated version of the game, we'll
# use the following set of letters and their associated point values:
# Letter 	 Points
#   c 	      3
#   e 	      1
#   l 	      1
#   n 	      1
#   t 	      1
#   x 	      8
#   y     	  4
#
# The goal is to write a program that calculates the score for the word "excellently".
# It would also be handy to know the total points accumulated for any given letter.

# 1. Create a literal hash called 'letters' with the letters (as strings) and their
#    associated point values shown in the table above

puts "Word: 'excellently'"
letters = {'c' => 3, 'e' => 1, 'l' => 1, 'n' => 1, 't' => 1, 'x' => 8, 'y' => 4}

puts "Letter values: #{letters}"

# 2. Now iterate through the characters in the word "excellently" and calculating the
#    word score by looking up each character's point value in the letters hash and
#    accumulating the values in a variable called score

total = 0

"excellently".each_char {|char| total += letters[char]}

puts "Total: #{total}"

# 3. Now we'd like to know the total points accumulated for each letter in the word.

points_total = Hash.new(0) #initialize hash value to 0

"excellently".each_char {|char| points_total[char] += letters[char]}

puts "Points total: #{points_total}"

# 4. Finally, use point total to calculate the word score a different way.

puts "New points total: #{points_total.values.reduce(:+)}"
