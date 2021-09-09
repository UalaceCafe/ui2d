module UI2D
  class Slider < Ruby2D::Entity
    attr_reader :initial_value, :value, :clicked, :min, :max, :x, :y, :width, :height, :color1, :color2

    def initialize(initial_value, opts={})
      @x = opts[:x] || 100
      @y = opts[:y] || 100
      @width = opts[:width] || 100
      @height = 8
      @color1 = opts[:color1] || 'white'
      @color2 = opts[:color2] || 'white'

      @min = opts[:min] || 0
      @max = opts[:max] || 10

      @clicked = false

      @initial_value = if initial_value < @min
                         @min
                       elsif initial_value > @max
                         @max
                       else
                         initial_value
                       end
      @value = @initial_value
    end

    def render; end

    def update
      Rectangle.new(x: @x, y: @y, width: @width, height: @height, color: [0.5, 0.5, 0.5, 1.0])
      Rectangle.new(x: @x + 1, y: @y + 1, width: @width - 2, height: @height - 2, color: @color1)

      x = map(@value, @min, @max, @x, @x + @width)

      clicked?
      if @clicked
        x = clamp(Window.mouse_x, @x, @x + @width)
        @value = map(x, @x, @x + @width, @min, @max)
      end
      y = @y + (@height / 2)

      @c1 = Circle.new(x: x, y: y, z: 1, radius: 5, color: [0.5, 0.5, 0.5, 1.0])
      @c2 = Circle.new(x: x, y: y, z: 1, radius: 4, color: @color2)
    end

    private

    def clicked?
      Window.on(:mouse_down) do |event|
        @clicked = if event.button == :left && @c2.contains?(Window.mouse_x, Window.mouse_y) && !@clicked
                     true
                   elsif event.button == :left && @c2.contains?(Window.mouse_x, Window.mouse_y) && @clicked
                     false
                   else
                     false
                   end
      end
    end

    def map(value, a1, a2, b1, b2)
      raise ArgumentError, 'Division by 0 - a1 cannot be equal to a2' if a2 == a1

      slope = 1.0 * (b2 - b1) / (a2 - a1)
      b1 + slope * (value - a1)
    end

    def clamp(x, a, b)
      [[x, a].max, b].min
    end
  end
end
