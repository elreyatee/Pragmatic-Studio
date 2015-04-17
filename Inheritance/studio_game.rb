require_relative 'game'

# player1 = Player.new("moe")
# player2 = Player.new("larry", 60)
# player3 = Player.new("curly", 125)

new_game = Game.new("Knuckleheads")
new_game.load_players(ARGV.shift || "players.csv")
# new_game.add_player(player1)
# new_game.add_player(player2)
# new_game.add_player(player3)
klutz = ClumsyPlayer.new("klutz", 105)
new_game.add_player(klutz)
berserker = BerserkPlayer.new("berserker", 50)
new_game.add_player(berserker)

loop do
  puts "\nHow many game rounds? ('quit' to exit)"
  answer = gets.chomp.downcase

  case answer
  when /^\d+$/
    new_game.play(answer.to_i) do
      new_game.total_points >= 2000
    end
  when 'quit', 'exit'
    new_game.print_stats
    new_game.save_high_scores
    break
  else
    puts "Please enter a number or 'quit'"
  end
end

# players = [player1, player2, player3]

# puts "There are #{players.size} players in the game"

# # players.each do |plyr|
# #   puts plyr.blam
# #   puts plyr
# # end

# players.pop
# players.push(player4 = Player.new("shemp", 90))
# puts players
