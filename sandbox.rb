require "./sandbox.rb"
require "./snake.rb"

require "awesome_print"
require "curses"
require "logger"

# this enable this ruby script to be run from the command line
Sandbox.new.main if __FILE__ == $PROGRAM_NAME

class Sandbox

  def exp1
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
  
  def main
    

    Curses.init_screen
    begin
      x = Curses.cols / 2  # We will center our text
      y = Curses.lines / 2
  
      Curses.setpos(y, x)  # Move the cursor to the center of the screen
      Curses.addstr("Hello World")  # Display the text
      Curses.refresh  # Refresh the screen
      Curses.getch  # Waiting for a pressed key to exit
  
      Curses.setpos(y + 1, x)  # Move the cursor to the center of the screen
      Curses.addstr("Ping!")  # Display the text
    # Curses.refresh  # Refresh the screen
      Curses.getch  # Waiting for a pressed key to exit
    
      Curses.setpos(y + 2, x)  # Move the cursor to the center of the screen
      Curses.addstr("Pong!")  # Display the text
      Curses.refresh  # Refresh the screen

      Curses.getch  # Waiting for a pressed key to exit
    ensure
      Curses.close_screen
    end
  end  
  
end






