# rubocop:disable Naming/UncommunicativeMethodParamName
class Food
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def draw
    Gosu.draw_rect(@x, @y, Snake::SIZE, Snake::SIZE, Gosu::Color::RED)
  end

  def self.random(width, height)
    x = (0...width).to_a.sample * Snake::SIZE
    y = (0...height).to_a.sample * Snake::SIZE

    Food.new(x, y)
  end
end
# rubocop:enable Naming/UncommunicativeMethodParamName