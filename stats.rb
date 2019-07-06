class Stats
  attr_reader :map, :player, :treasure, :moves

  def initialize(map:, player:, treasure:)
    @map = map

    @player = player

    @treasure = treasure

    @moves = 0
  end

  def move
    @moves += 1
  end

  def render
    "Dwarven source beam: #{treasure_distance.round}\n" +
    "Moves: #{moves}"
  end

  def found_treasure?
    treasure_distance == 0
  end

  private

  def treasure_distance
    player.distance(treasure)
  end
end
