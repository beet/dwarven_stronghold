=begin

The Map object is instantiated with a multidimendional array used populate the map with walls.

For example, an array like:

    [
      [1, 2, 3],
      [1, 3],
      [1, 2, 3]
    ]

Would produce a map that looks like:

    ###
    # #
    ###

It can place objects randomly within the map, move them around the map, and
tell you whether a given point is a wall or not.

=end
class Map
  attr_reader :coordinates, :objects

  def initialize(coordinates = [])
    @coordinates = coordinates

    @objects = []

    populate_walls
  end

  # Will place the given object at a random position in the map by setting its
  # X/Y coordinates
  def place_oject_randomly(object)
    while is_wall?(object.location)
      object.location_x = 1 + rand(width - 1)

      object.location_y = 1 + rand(height - 1)
    end

    objects << object
  end

  # Renders a text view of the map
  def render
    "".tap do |output|
      (1..height).each do |y|
        (1..width).each do |x|
          object = object_at(Locatable::Point.new(x: x, y: y))

          output << (object.nil? ? "  " : object.sprite)
        end

        output << "\n"
      end
    end
  end

  # Moves an the given object up (North), unless that location is a wall
  def move_object_up(object)
    object.location_move_up unless is_wall?(object.location_up)
  end

  # Moves an the given object down (South), unless that location is a wall
  def move_object_down(object)
    object.location_move_down unless is_wall?(object.location_down)
  end

  # Moves an the given object left (West), unless that location is a wall
  def move_object_left(object)
    object.location_move_left unless is_wall?(object.location_left)
  end

  # Moves an the given object right (East), unless that location is a wall
  def move_object_right(object)
    object.location_move_right unless is_wall?(object.location_right)
  end

  # Geven a Locatable object, returns true if its location coresponds to a
  # wall in the map
  def is_wall?(point)
    objects.any? do |object|
      object.location == point && object.is_wall?
    end
  end

  private

  def width
    coordinates.map(&:size).max
  end

  def height
    coordinates.size
  end

  def populate_walls
    coordinates.each_index do |y|
      coordinates[y].each do |x|
        wall = WorldObjects::Structures::Wall.new

        # The X axis in the coordinates array is human-indexed
        wall.location_x = x

        # The Y axis in the coordinates array is zero-indexed
        wall.location_y = y + 1

        objects << wall
      end
    end
  end

  def object_at(point)
    objects.detect do |object|
      object.location == point
    end
  end
end
