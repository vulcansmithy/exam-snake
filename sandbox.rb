require "./sandbox.rb"
require "./snake.rb"

require "awesome_print"

# this enable this ruby script to be run from the command line
Sandbox.new.main if __FILE__ == $PROGRAM_NAME

class Sandbox

  def main
    snake = Snake.new
    snake.x_pos = 0
    snake.y_pos = 0
    snake.orientation = Snake::FACING_EAST
    snake.report

    snake.turn_right
    snake.report

    snake.turn_right
    snake.report

    snake.turn_right
    snake.report

    snake.turn_right
    snake.report
  end
  
end






