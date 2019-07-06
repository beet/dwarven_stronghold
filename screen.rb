class Screen
  require "tty-box"

  attr_reader :map_box, :stats_box

  def initialize
    @map_box = nil

    @stats_box = nil
  end

  def refresh
    print TTY::Cursor.clear_screen

    print map_box

    print stats_box

    puts "\nUp: W, Down: S, Left: A, Right D"
    puts "\nExit: CTRL+X or Escape"
  end

  def render_map(map)
    @map_box = TTY::Box.frame(
      top: 0,
      left: 0,
      width: 32,
      height: 17,
      title: { top_left: "Map" }
    ) do
      map
    end
  end

  def render_stats(stats)
    @stats_box = TTY::Box.frame(
      top: 0,
      left: 33,
      width: 32,
      height: 17,
      title: { top_left: "Stats" }
    ) do
      stats
    end
  end
end
