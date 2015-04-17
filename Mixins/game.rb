require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'
require_relative 'clumsy_player'
require_relative 'berserk_player'
require 'csv'

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def high_score_entry(player)
    "#{player.name}".ljust(20, '.') + "#{player.score}"
  end

  # def load_players(filename)
  #   File.readlines(filename).each do |line|
  #     self.add_player(Player.from_csv(line))
  #   end
  # end

  def load_players(filename)
    CSV.foreach(filename) do |row|
      player = Player.new(row[0], row[1].to_i)
      self.add_player(player)
    end
  end

  def save_high_scores(filename="high_scores.txt")
    File.open(filename, "w") do |file|
      file.puts "#{@title} High Scores:"
      @players.sort.each do |player|
        file.puts high_score_entry(player)
      end
    end
  end

  def add_player(player)
    @players << player
  end

  def play(rounds)
    1.upto(rounds) do |round|

      if block_given?
        break if yield
      end

      puts "There are #{@players.size} players in #{@title}:"

      @players.each do |player|
        puts player
      end

      treasures = TreasureTrove::TREASURES
      puts "\nThere are #{treasures.size} treasures to be found:"
      treasures.each do |treasure|
        puts "A #{treasure.name} is worth #{treasure.points} points."
      end

      1.upto(rounds) do |round|
        puts "\nRound #{round}:"
        @players.each do |player|
          GameTurn.take_turn(player)
          # puts player
        end
      end
    end
  end

  def print_name_and_health(players)
    players.each do |player|
      "#{player.name} (#{player.health})"
    end
  end

  def print_stats
    strong_players, wimpy_players = @players.partition { |player| player.strong? }

    puts "\n#{@title} Statistics:"

    puts "\n#{strong_players.size} strong players:"
    puts print_name_and_health(strong_players)

    puts "\n#{wimpy_players.size} wimpy players:"
    puts print_name_and_health(wimpy_players)

    @players.each do |player|
      puts "\n#{player.name}'s point totals:"
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
      puts "#{player.score} grand total points"
    end

    puts "\n#{@title} High Scores:"
    @players.sort.each do |player|
      puts high_score_entry(player)
    end

    puts "#{total_points} total points from treasures found."
  end

  def total_points
    @players.reduce(0) {|sum, player| sum + player.points}
  end
end
