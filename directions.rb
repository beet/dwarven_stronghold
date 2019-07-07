class Directions
  attr_reader :map, :player

  def initialize(map:, player:)
    @map = map

    @player = player
  end

  def render
    "North: #{view(north)}\n" +
    "South: #{view(south)}\n" +
    "East: #{view(east)}\n" +
    "West: #{view(west)}\n"
  end

  private

  def north
    player.location_up
  end

  def south
    player.location_down
  end

  def east
    player.location_right
  end

  def west
    player.location_left
  end

  def view(position)
    map.is_wall?(position) ? "Wall" : "Open"
  end
end
