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
    "Moves: #{moves}\n" + 
    objects
  end

  def found_treasure?
    treasure_distance == 0
  end

  private

  def treasure_distance
    player.location_distance(treasure.location)
  end

  # Should tell the map to give us the objects at the plauer's location, not
  # ask for all obects at a location  that is the player's. Except that the
  # map is agnostic to which of the objects is the player...
  def objects_at_location
    map.objects_at_player_location
  end

  def objects
    "".tap do |text|
      objects = objects_at_location

      next if objects.none?

      text << objects.map { |object| "There is a #{object.description} here!" }.join("\n")
    end
  end
end
