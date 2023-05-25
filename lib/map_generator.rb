# Based on [How to code your own procedural dungeon map generator using the Random Walk Algorithm](https://www.freecodecamp.org/news/how-to-make-your-own-procedural-dungeon-map-generator-using-the-random-walk-algorithm-e0085c8aa9a/)
# This is interesting too: [Rooms and Mazes: A Procedural Dungeon Generator – journal.stuffwithstuff.com](http://journal.stuffwithstuff.com/2014/12/21/rooms-and-mazes/)
class MapGenerator
  attr_reader :size, :tunnels, :tunnel_length, :coordinates, :cursor

  def initialize(size:, tunnels:, tunnel_length:)
    @size = size
    @tunnels = tunnels
    @tunnel_length = tunnel_length
    @coordinates = []
  end

  def run
    initialise_coordinates

    randomise_starting_point

    tunnels.times do
      in_valid_random_direction do |direction|
        rand(tunnel_length).times do
          cursor.send("move_#{direction}") # bit nasty, cursor.move(direction) would be nicer

          mine_at_cursor

          break unless within_edges?(cursor.send(direction))
        end
      end
    end

    coordinates
  end

  private

  def initialise_coordinates
    size.times do
      row = []

      size.times do
        row << 1
      end

      coordinates << row
    end
  end

  def randomise_starting_point
    @cursor = Locatable::Point.new(x: rand(size), y: rand(size))
  end

  def in_valid_random_direction(&block)
    direction = %w(up down left right).map do |direction|
      within_edges?(cursor.send(direction)) ? direction : nil
    end.compact.sample

    yield direction
  end

  def within_edges?(point)
    point.x > 0 && point.x < (size-1) && point.y > 0 && point.y < (size-1)
  end

  def mine_at_cursor
    @coordinates[cursor.y][cursor.x] = 0
  rescue NoMethodError => e
    puts cursor.inspect

    raise e
  end
end

class MapConverter
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
  end

  def run
    [].tap do |array|
      coordinates.each_with_index do |row, row_index|
        array << [].tap do |row|
          coordinates[row_index].each_with_index do |column, column_index|
            row << column_index + 1 if column == 1
          end
        end
      end
    end
  end
end

# require_relative "locatable"
# require "pp"
# generator = MapGenerator.new(size:15, tunnels: 150, tunnel_length: 5)
# generator.run
# # pp generator.coordinates
# generator.coordinates.each do |row|
#   puts row.join
# end

# pp MapConverter.new(generator.coordinates).run
