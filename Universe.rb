require "gosu"
require_relative "z_order"

class Universe
  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @bodies = []
  end

def draw

end
