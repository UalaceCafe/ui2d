module UI2D
  class RadioButton < Ruby2D::Entity
    attr_reader :x, :y, :radius, :color1, :color2
    attr_accessor :active

    def initialize(active, opts = {})
      @x = opts[:x] || 100
      @y = opts[:y] || 100
      @radius = opts[:radius] || 8
      @color1 = opts[:color1] || [0.5, 0.5, 0.5, 1.0]
      @color2 = opts[:color2] || 'white'
      @color3 = opts[:color3] || @color1
      @active = active
    end

    def update
      @outline = Circle.new(x: @x, y: @y, radius: @radius, color: @color1)
      @inner = Circle.new(x: @x, y: @y, radius: @radius - 2, color: @color2)

      clicked?
      @selection = Circle.new(x: @x, y: @y, radius: (@radius - 2) / 2, color: @color3) if @active
    end

    def clicked?
      Window.on(:mouse_down) do |event|
        @active = if event.button == :left && contains?(Window.mouse_x, Window.mouse_y) && !@active
                    true
                  elsif event.button == :left && contains?(Window.mouse_x, Window.mouse_y) && @active
                    false
                  elsif event.button == :left && !contains?(Window.mouse_x, Window.mouse_y)
                    @active
                  end
      end
    end

    def render; end

    alias active? active

    private

    def contains?(x, y)
      # ((x - @x)**2 + (y - @y)**2) < (@radius**2)
      # Seems to be faster:
      dx = (x - @x).abs
      return false if dx > @radius

      dy = (y - @y).abs
      return false if dy > @radius
      return true if dx + dy <= @radius

      dx**2 + dy**2 <= @radius**2
    end
  end
end
