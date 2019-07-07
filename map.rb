class Map
  attr_reader :coordinates, :objects

  def initialize(coordinates = [])
    @coordinates = coordinates

    @objects = []

    populate_walls
  end

  def place_oject_randomly(object)
    while is_wall?(object.location)
      object.location_x = 1 + rand(width - 1)

      object.location_y = 1 + rand(height - 1)
    end

    objects << object
  end

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

  def move_object_up(object)
    object.location_move_up unless is_wall?(object.location_up)
  end

  def move_object_down(object)
    object.location_move_down unless is_wall?(object.location_down)
  end

  def move_object_left(object)
    object.location_move_left unless is_wall?(object.location_left)
  end

  def move_object_right(object)
    object.location_move_right unless is_wall?(object.location_right)
  end

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

        wall.location_x = x

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
