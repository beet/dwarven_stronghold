require "rubygems"

Dir["#{__dir__}/**/*.rb"].each do |file|
  require_relative file
end

=begin

The Game object loads and initialises the various other game objects and uses
tty-reader to connect key-press events to functions that control gameplay,
like moving the player around the map and refreshing the screen.

=end
class Game
  require "tty-reader"
  require "tty-cursor"
  require "faker"

  KEYBOARD_DIRECTION_MAPPINGS = {
    w: :up,
    a: :left,
    s: :down,
    d: :right,
  }

  attr_reader :map, :stats, :screen, :player, :treasure, :keyboard_input, :directions, :monsters, :items, :cursor

  def initialize(coordinates)
    @map = Map.new(coordinates)

    @screen = Screen.new

    initialise_player

    initialise_treasure

    initialise_monsters

    initialise_items

    @stats = Stats.new(map: map, player: player, treasure: treasure)

    @keyboard_input = TTY::Reader.new
    @cursor = TTY::Cursor
    cursor.hide

    register_key_events

    @directions = Directions.new(map: map, player: player)
  end

  def play
    refresh_screen

    show_map
    monsters.each { |monster| render_object(monster) }
    items.each { |item| render_object(item) }
    render_object(player)
    cursor.hide
    print cursor.move_to(0, 0)

    loop do
      keyboard_input.read_line(echo: false)
    end
  end

  private

  def initialise_player
    @player = WorldObjects::Player.new

    map.place_oject_randomly(player)
  end

  def initialise_treasure
    @treasure = WorldObjects::Items::Treasure.new

    map.place_oject_randomly(treasure)
  end

  def initialise_monsters
    @monsters = []

    5.times do
      monster = WorldObjects::Creatures::Monster.new

      monsters << monster

      map.place_oject_randomly(monster)
    end
  end

  def initialise_items
    @items = []

    5.times do
      item = WorldObjects::Items::Item.new

      items << item

      map.place_oject_randomly(item)
    end
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
    clear_cursor_at(player)

    if map.send("move_object_#{direction.to_s}", player)
      stats.move

      refresh_screen

      monsters.each { |monster| clear_cursor_at(monster) }
      move_monsters
      monsters.each { |monster| render_object(monster) }

      if stats.found_treasure?
        # show_map

        puts "\nYAY! You found the treasure in #{stats.moves} moves!"

        exit
      end
    end

    items.each { |item| render_object(item) }

    render_object(player)
    cursor.hide
    print cursor.move_to(0, 0)
  end

  def move_monsters
    monsters.each do |monster|
      map.send("move_object_#{KEYBOARD_DIRECTION_MAPPINGS.values.sample}", monster)
    end
  end

  def refresh_screen
    # screen.render_map(directions.render)
    # screen.render_map(map.render)

    screen.render_stats(stats.render)

    screen.refresh
  end

  def show_map
    screen.render_map(map.render)

    screen.refresh
  end

  def clear_cursor_at(object)
    move_cursor_to(object)

    # print "  "
    cursor.clear_char(2)
  end

  def render_object(object)
    move_cursor_to(object)
    
    print object.sprite
  end

  def move_cursor_to(object)
    print cursor.move_to(object.location_x * 2 - 1, object.location_y)
  end
end
