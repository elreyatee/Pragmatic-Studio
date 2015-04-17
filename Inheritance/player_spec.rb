require_relative 'player'
require_relative 'treasure_trove'

describe Player do

  before do
    @initial_health = 150
    @player = Player.new("larry", @initial_health)
  end

  it "has a capitalized name" do

    expect(@player.name).to eq("Larry")
  end

  it "has an initial health" do

    expect(@player.health).to eq(@initial_health)
  end

  it "has a string representation" do
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:hammer, 50))

    expect(@player.to_s).to eq("I'm Larry with a health = 150, points = 100, and a score = 250.")
  end

  it "increases health by 15 when w00ted" do
    @player.w00t

    expect(@player.health).to eq(@initial_health + 15)
  end

  it "decreases health by 10 when blammed" do
    @player.blam

    expect(@player.health).to eq(@initial_health - 10)
  end

  it "computes points as the sum of all treasure points" do
    expect(@player.points).to eq(0)

    @player.found_treasure(Treasure.new(:hammer, 50))

    expect(@player.points).to eq(50)

    @player.found_treasure(Treasure.new(:crowbar, 400))

    expect(@player.points).to eq(450)

    @player.found_treasure(Treasure.new(:hammer, 50))

    expect(@player.points).to eq(500)
  end

  it "computes a score as the sum of its health and points" do
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:hammer, 50))

    expect(@player.score).to eq(250)
  end

  it "yields each found treasure and its total points" do
    @player.found_treasure(Treasure.new(:skillet, 100))
    @player.found_treasure(Treasure.new(:skillet, 100))
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))

    yielded = []
    @player.each_found_treasure do |treasure|
      yielded << treasure
    end

    expect(yielded).to eq([
      Treasure.new(:skillet, 200),
      Treasure.new(:hammer, 50),
      Treasure.new(:bottle, 25)
    ])
  end

  it "can be created from a CSV string" do
    string = "Daredevil,100"
    player = Player.from_csv(string)

    expect(player.name).to eq("Daredevil")
    expect(player.health).to eq(100)
  end

  context "with health greater than 100" do
    before do
      @initial_health = 150
      @player = Player.new("larry", @initial_health)
    end

    it "is a strong player" do
      expect(@player).to be_strong
    end
  end

  context "with health less than equal to 100" do
    before do
      @initial_health = 100
      @player = Player.new("larry", @initial_health)
    end

    it "is a wimpy player" do
      expect(@player).not_to be_strong
    end
  end

end
