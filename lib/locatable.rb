module Locatable
  class Point
    include Comparable

    attr_accessor :x, :y

    def initialize(x: nil, y: nil)
      @x = x
      @y = y
    end

    def <=>(other_point)
      return -1 if x < other_point.x && y < other_point.y

      return 0 if x == other_point.x && y == other_point.y

      return 1 if x > other_point.x && y > other_point.y
    end

    # Note: always returns a positive number, not to be used with negative X/Y
    # values
    def distance(other_point)
      Math.sqrt((x - other_point.x)**2 + (y - other_point.y)**2)
    end

    def up
      Point.new(x: x, y: y - 1)
    end

    def down
      Point.new(x: x, y: y + 1)
    end

    def left
      Point.new(x: x - 1, y: y)
    end

    def right
      Point.new(x: x + 1, y: y)
    end

    def move_up
      @y -= 1
    end

    def move_down
      @y += 1
    end

    def move_left
      @x -= 1
    end

    def move_right
      @x += 1
    end

    private

    def zero_point
      Point.new(x: 0, y: 0)
    end
  end

  def self.included(klass)
    klass.class_eval do
      def location
        @location ||= Point.new(x: 1, y: 1)
      end

      (Locatable::Point.instance_methods - Object.methods).each do |method|
        define_method("location_#{method}".to_sym) do |*args, &block|
          location.send(method, *args)
        end
      end
    end
  end
end
