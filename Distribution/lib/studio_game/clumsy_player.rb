require_relative 'player'

module StudioGame
  class ClumsyPlayer < Player
    attr_reader :boost_factor

    def initialize(name, health = 100, boost_factor = 1)
      super(name, health)
      @boost_factor = boost_factor
    end

    def found_treasure(treasure)
      broken_treasure = Treasure.new(treasure.name, treasure.points / 2.0)
      super(broken_treasure)
      # puts "#{self.name}'s treasures: #{@found_treasures}."
    end

    def w00t
      @boost_factor.times {super}
    end
  end

  if __FILE__ == $0
    clumsy = ClumsyPlayer.new("klutz")

    hammer = Treasure.new(:hammer, 50)
    clumsy.found_treasure(hammer)
    clumsy.found_treasure(hammer)
    clumsy.found_treasure(hammer)

    crowbar = Trasure.new(:crowbar, 400)
    clumsy.found_trasure(crowbar)

    clumsy.each_found_treasure do |treasure|
      puts "#{treasure.points} total #{treasure.name} points"
    end
    puts "#{clumsy.points} grant total points"
  end
end
