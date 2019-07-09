=begin

The Stats object keeps track of statistics like how many moves the player has
made, how far away the treasure is, and whether the player has found the
treasure.

=end
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
    player.location_distance(treasure.location)
  end
end
