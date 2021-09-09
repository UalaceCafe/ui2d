require 'ruby2d'
require_relative '../lib/ui2d'

set(title: 'UI2D Example', width: 256, height: 256, background: 'blue')

WIDTH = Window.width
HEIGHT = Window.height

slider = UI2D::Slider.new(0, x: 78, min: 0, max: 100)
radio = UI2D::RadioButton.new(false, x: 78, y: 150, color1: 'red', color3: 'black')

update do
  clear

  slider.add
  Text.new(slider.value.to_i, x: slider.x + slider.width + 5, y: slider.y - 5, size: 15, style: :bold)

  radio.add
  Text.new(radio.active? ? 'Selected' : 'Not Selected', x: radio.x + 15, y: radio.y - 8, size: 15, style: :bold)
end

show
