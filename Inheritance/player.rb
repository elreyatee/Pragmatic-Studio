require_relative 'treasure_trove'

class Player
  attr_accessor :name
  attr_reader :health

  def initialize(name, health = 100)
    @name = name.capitalize
    @health = health
    @found_treasures = Hash.new(0)
  end

  def self.from_csv(string)
    name, health = string.split(',')
    Player.new(name, Integer(health))
  end

  def each_found_treasure
    @found_treasures.each do |name, points|
      yield Treasure.new(name, points)
    end
  end

  def found_treasure(treasure)
    @found_treasures[treasure.name] += treasure.points
    puts "#{self.name} found a #{treasure.name} worth #{treasure.points} points."
    # puts "#{self.name}'s treasures: #{@found_treasures}."
  end

  def points
    @found_treasures.values.reduce(0, :+)
  end

  def to_s
    "I'm #{@name} with a health = #{@health}, points = #{points}, and a score = #{score}."
  end

  def blam
    @health -= 10
    "#{@name} got blammed!"
  end

  def w00t
    @health += 15
    puts "#{@name} got w00ted!"
  end

  def score
    @health + self.points
  end

  def name=(new_name)
    @name = new_name.capitalize
  end

  def strong?
    @health > 100
  end

  def <=>(other)
    other.score <=> self.score
  end
end

if __FILE__ == $0
  player = Player.new("moe")
  puts player.name
  puts player.health
  player.w00t
  puts player.health
  player.blam
  puts player.health
end
