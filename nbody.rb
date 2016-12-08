require "gosu"
require_relative "z_order"
require "./planets"

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @bodies = []
    @number_of_bodies = 0
    @size_of_simulation = 0
    @create_bodies
  end

  def create_bodies
    open_simulation = File.open("simulations/planets.txt").read
    line_num = 0
    open_simulation.split("\n")
    open_simulation.each_line do |line|
      if line_num == 0
        @number_of_bodies = line.to_f
      elsif line_num == 1
        @size_of_simulation = line.to_f
      elsif line_num >= 2 && line_num <= 2 + @number_of_bodies
        arry = line.split(" ")
        x_pos = arry[0].to_f
        y_pos = arry[1].to_f
        x_vel = arry[2].to_f
        y_vel = arry[3].to_f
        mass = arry[4].to_f
        planet_image = Gosu::Image.new("images/#{arry[5]}", tileable: true)
        @bodies.push(Planets.new(x_pos, y_pos, x_vel, y_vel, mass, planet_image, @size_of_simulation))
      end
    end
  end

def update
  @bodies.each do |body1|
    @bodies.each do|body2|
      if body1 != body2
        body1.forcex(body2.x_pos, body2.y_pos, body2.mass)
        body1.forcey(body2.x_pos, body2.y_pos, body2.mass)
      end
    end
    body1.acclx
    body1.accly
    body1.bringthatboidown
  end
end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodies.each do |body|
      body.draw
    end
  end

  def button_down(id)
        close if id == Gosu::KbEscape
  end


end

window = NbodySimulation.new
window.show
