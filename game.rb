require "rubygems"
require "forwardable"
require_relative "point"
require_relative "player"
require_relative "treasure"
require_relative "wall"
require_relative "map"
require_relative "stats"
require_relative "screen"
require_relative "directions"

class Game
  require "tty-reader"

  KEYBOARD_DIRECTION_MAPPINGS = {
    w: :up,
    a: :left,
    s: :down,
    d: :right,
  }

  attr_reader :map, :stats, :screen, :player, :treasure, :keyboard_input, :directions

  def initialize(coordinates)
    @map = Map.new(coordinates)

    @screen = Screen.new

    initialise_player

    initialise_treasure

    @stats = Stats.new(map: map, player: player, treasure: treasure)

    @keyboard_input = TTY::Reader.new

    register_key_events

    @directions = Directions.new(map: map, player: player)
  end

  def play
    refresh_screen

    loop do
      keyboard_input.read_line(echo: false)
    end
  end

  private

  def initialise_player
    @player = Player.new(x: 1, y: 1)

    map.place_oject_randomly(player)
  end

  def initialise_treasure
    @treasure = Treasure.new(x: 1, y: 1)

    map.place_oject_randomly(treasure)
  end

  def register_key_events
    keyboard_input.on(:keypress) do |event|
      if %w(w a s d).include?(event.value)
        move_player(KEYBOARD_DIRECTION_MAPPINGS[event.value.to_sym])
      end

      if event.value == "m"
        show_map
      end
    end

    keyboard_input.on(:keyctrl_x, :keyescape) do
      puts "Exiting..."
      exit
    end
  end

  def move_player(direction)
    if map.send("move_object_#{direction.to_s}", player)
      stats.move

      refresh_screen

      if stats.found_treasure?
            show_map

        puts "\nYAY! You found the treasure in #{stats.moves} moves!"

        exit
      end
    end
  end

  def refresh_screen
    screen.render_map(directions.render)

    screen.render_stats(stats.render)

    screen.refresh
  end

  def show_map
    screen.render_map(map.render)

    screen.refresh
  end
end

# Could load from a file?
coordinates = [
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11, 12, 13, 14, 15],
  [1, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15],
  [1, 2, 4, 5, 6, 7, 8, 15],
  [1, 2, 4, 5, 6, 7, 8, 10, 11, 12, 13, 14, 15],
  [1, 2, 4, 5, 6, 7, 8, 13, 14, 15],
  [1, 2, 9, 10, 11, 13, 14, 15],
  [1, 2, 3, 4, 5, 6, 7, 10, 11, 15],
  [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 13, 15],
  [1, 2, 11, 13, 14, 15],
  [1, 2, 4, 5, 6, 7, 8, 9, 15],
  [1, 2, 8, 9, 11, 12, 13, 14, 15],
  [1, 2, 3, 4, 5, 6, 8, 9, 11, 12, 13, 14, 15],
  [1, 2, 3, 4, 5, 6, 8, 9, 11, 12, 13, 14, 15],
  [1, 8, 9, 15],
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11, 12, 13, 14, 15],
]

game = Game.new(coordinates)

game.play
