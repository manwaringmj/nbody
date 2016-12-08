require "gosu"

class Planets
  attr_reader :x_pos, :y_pos, :x_vel, :y_vel, :mass, :force_x, :force_y, :planet_image
  def initialize(x_pos, y_pos, x_vel, y_vel, mass, planet_image, size_of_simulation)
    @x_pos = x_pos
    @y_pos = y_pos
    @x_vel = x_vel
    @y_vel = y_vel
    @mass = mass
    @planet_image = planet_image
    @force_x = 0
    @force_y = 0
    @G = 6.674e-11
    @size_of_simulation = size_of_simulation
  end
  def forcex(x, y, mass)
      force = (@G * @mass * mass)/((@x_pos - x)**2 + (@y_pos + y)**2)
      @force_x -= force * ((@x_pos - x)/Math.sqrt((@x_pos - x)**2 + (@y_pos + y)**2))
  end
  def forcey (x, y, mass)
      force = (@G * @mass * mass)/((@x_pos - x)**2 + (@y_pos + y)**2)
      @force_y -= force * ((@y_pos - y)/Math.sqrt((@x_pos - x)**2 + (@y_pos + y)**2))
  end
  def acclx
    acc = @mass / @force_x
    @x_vel += acc * 25000
    @x_pos += @x_vel * 25000
  end
  def accly
    acc = @mass / @force_y
    @y_vel += acc * 25000
    @y_pos += @y_vel *25000
  end
  def bringthatboidown
    @force_x = 0
    @force_y = 0
  end

  def draw
    @planet_image.draw((@x_pos * 320/@size_of_simulation + 320 ), (@y_pos * 320/@size_of_simulation + 320), ZOrder::Bodies)
  end

end
