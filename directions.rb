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
    player.up
  end

  def south
    player.down
  end

  def east
    player.right
  end

  def west
    player.left
  end

  def view(position)
    map.is_wall?(position) ? "Wall" : "Open"
  end
end
