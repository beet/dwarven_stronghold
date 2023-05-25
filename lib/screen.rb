=begin

The Screen object uses tty-box to render screen components like the map and
stats panes.

Hmmm... [Ruby 2D](https://www.ruby2d.com/)

=end
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

    puts controls_box
  end

  def render_map(map)
    @map_box = TTY::Box.frame(
      top: 0,
      left: 0,
      width: 62,
      height: 32,
      title: { top_left: "Map" }
    ) do
      map
    end
  end

  def render_stats(stats)
    @stats_box = TTY::Box.frame(
      top: 0,
      left: 63,
      width: 32,
      height: 17,
      title: { top_left: "Stats" }
    ) do
      stats
    end
  end

  private

  def controls_box
    @controls_box ||= TTY::Box.frame(
      top: 32,
      left: 0,
      width: 94,
      height: 5,
      title: { top_left: "Controls" }
    ) do
      [
        "Up: W, Down: S, Left: A, Right D",
        "Show map: M",
        "Exit: CTRL+X or Escape",
      ].join("\n")
    end
  end
end
