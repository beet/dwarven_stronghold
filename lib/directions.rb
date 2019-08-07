=begin

The Directions object uses the map and player objects to render text
directions of what the player can see.

  directions = Directions.new(map: map, player: payer)

  directions.render

  "North: Open
  South: Open
  East: Wall
  West: Wall"

=end
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
    map.objects_at(position)
      .collect(&:description)
      .join(", ")
      .tap { |description| description << "open" if description == "" }
  end
end
