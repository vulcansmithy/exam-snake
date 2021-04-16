$VERBOSE = nil

require "./sandbox.rb"
require "./snake.rb"

require "awesome_print"
require "curses"
require "logger"

# this enable this ruby script to be run from the command line
Sandbox.new.main if __FILE__ == $PROGRAM_NAME

class Sandbox
  
  SNAKE_CHAR = "#{0x2588.chr(Encoding::UTF_8)}"
  
  def initialize
    @log = Logger.new("./logs/sandbox-debug.log") 
  end  

  def main
    Curses.init_screen
    Curses.curs_set(0)
    Curses.init_screen
    Curses.start_color
    Curses.noecho
    
    points = 0
    delay  = 0.60
     
    begin
      win = Curses.stdscr
      win.box("|", "-")

      win.nodelay = true
      win.keypad = true

      initial_x = win.maxx / 2
      initial_y = win.maxy / 2
      snake = Snake.new(initial_x, initial_y, Snake::FACING_EAST, win.maxx, win.maxy)

      win.setpos(snake.y_pos, snake.x_pos)
      win.addstr("#{0x2588.chr(Encoding::UTF_8)}")
      win.refresh

      input = nil    
      while true

        crash = false
        input = win.getch

        if input == 27
          break
        elsif input == 'w' or input == Curses::Key::UP
          case snake.orientation
          when :east
            snake.turn_left
          when :west
            snake.turn_right  
          end

        elsif input == 's' or input == Curses::Key::DOWN
          case snake.orientation
          when :east
            snake.turn_right
          when :west
            snake.turn_left
          end

        elsif input == 'a' or input == Curses::Key::LEFT
          case snake.orientation
          when :north
            snake.turn_left
          when :south
            snake.turn_right  
          end

        elsif input == 'd' or input == Curses::Key::RIGHT
          case snake.orientation
          when :north
            snake.turn_right
          when :south
            snake.turn_left  
          end
        end

        snake.move
        win.setpos(snake.y_pos, snake.x_pos)

        if snake_crashed?(snake, win)  
          @log.debug "@DEBUG L:#{__LINE__}   Snake crashed..."
          exit 
        end

        # increase points
        points += 1

        sleep(delay)
        if points % 10 == 0
          delay -= 0.05 if delay > 0.20
        end

        win.addstr(SNAKE_CHAR)
        win.setpos(win.maxy - 1, 1)
        win.addstr("  Points: #{points}  ")

        win.refresh
      end 
    ensure
      win.nodelay = false
      show_message("  Total Points: #{points}. Press <Enter> to Quit")
      
      Curses.close_screen
    end
    
    
  end
  
  def snake_crashed?(snake, window)
    result = if window.inch != 32
      true
    elsif snake.orientation == Snake::FACING_NORTH and snake.y_pos < 0 + 1
      true
    elsif snake.orientation == Snake::FACING_EAST and snake.x_pos > window.maxx - 1
      true
    elsif snake.orientation == Snake::FACING_SOUTH and snake.y_pos > window.maxy - 1
      true
    elsif snake.orientation == Snake::FACING_WEST and snake.y_pos < 0 + 1
      true
    else
      false  
    end
  end  
  
  def show_message(message)
    height = 5
    width  = message.length + 6
    top    = (Curses.lines - height) / 2
    left   = (Curses.cols - width) / 2
    win = Curses::Window.new(height, width, top, left)
    win.box("|", "-")
    win.setpos(2, 3)
    win.addstr(message)
    win.refresh
    win.getstr
    win.close
  end
end
