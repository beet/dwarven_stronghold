class Map
  attr_reader :coordinates, :objects

  def initialize(coordinates = [])
    @coordinates = coordinates

    @objects = []

    populate_walls
  end

  def place_oject_randomly(object)
    while is_wall?(object)
      object.x = 1 + rand(width - 1)

      object.y = 1 + rand(height - 1)
    end

    objects << object
  end

  def render
    "".tap do |output|
      (1..height).each do |y|
        (1..width).each do |x|
          point = Point.new(x: x, y: y)

          object = object_at(point)

          output << (object.nil? ? "  " : object.sprite)
        end

        output << "\n"
      end
    end
  end

  def move_object_up(object)
    object.move_up unless is_wall?(object.up)
  end

  def move_object_down(object)
    object.move_down unless is_wall?(object.down)
  end

  def move_object_left(object)
    object.move_left unless is_wall?(object.left)
  end

  def move_object_right(object)
    object.move_right unless is_wall?(object.right)
  end

  def is_wall?(point)
    objects.any? do |object|
      object == point && object.is_wall?
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
        objects << Wall.new(x: x, y: y + 1)
      end
    end
  end

  def object_at(point)
    objects.detect do |object|
      object == point
    end
  end
end
