require 'ruby2d'

set background: 'navy'
set fps_cap: 20

# width = 640 / 20 = 32
# height = 480 / 20 = 24
GRID_SIZE = 20

class Snake
  attr_writer :direction

  def initialize
    @positions = [[2,0], [2,1], [2,2], [2,3]]
    @direction = 'down'
  end

  def draw
    @positions.each do |pos|
      Square.new(x: pos[0] * GRID_SIZE, y: pos[1] * GRID_SIZE, size: GRID_SIZE - 1, color: 'white')
    end
  end

  def move
  @positions.shift
    case @direction
    when 'down'
      @positions.push([head[0], head[1] + 1])
    when 'up'
      @positions.push([head[0], head[1] - 1])
    when 'left'
      @positions.push([head[0] - 1, head[1]])
    when 'right'
      @positions.push([head[0] + 1, head[1]])
    end
  end

  def can_change_direction_to?(new_direction)
    case @direction
      when 'up' then new_direction != 'down'
      when 'down' then new_direction != 'up'
      when 'left' then new_direction != 'right'
      when 'right' then new_direction != 'left'
    end
  end

  private

  def head
    @positions.last
  end
end

snake = Snake.new

update do
  clear

  snake.move
  snake.draw
end

on :key_down do |e|
  if ['up', 'down', 'left', 'right'].include?(e.key)
    if snake.can_change_direction_to?(e.key)
      snake.direction = e.key
    end
  end
end

show
