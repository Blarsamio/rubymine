class Snake
  SIZE = 20
  attr_reader :x, :y
  attr_accessor :length, :direction

  def initialize
    @x = 0
    @y = 0
    @length = 1
    @direction = 'right'
  end

  def draw
    Gosu.draw_rect(@x, @y, SIZE, SIZE, Gosu::Color::WHITE)
  end

  def set_direction
    if turn?(Gosu::KB_LEFT, "right")
      @snake.direction = "left"
    elsif turn?(Gosu::KB_RIGHT, "left")
      @snake.direction = "right"
    elsif turn?(Gosu::KB_UP, "bottom")
      @snake.direction = "top"
    elsif turn?(Gosu::KB_DOWN, "top")
      @snake.direction = "bottom"
    end
  end

  def move
    case @direction
      when "right" then @x += SIZE
      when "left" then @x -= SIZE
      when "bottom" then @y += SIZE
      when "top" then @y -= SIZE
    end
  end

  def update
    set_direction
    return if (Time.now - @last_move) < @speed

    @snake.move
    @last_move = Time.now

    # if still_in_bounds?
    #   eat if @snake.eat?(@food)
    # else
    #   reset_snake
    # end
  end

  def eat?(food)
    @x == food.x && @y == food.y
  end

end
