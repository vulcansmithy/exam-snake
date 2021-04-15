require "./sandbox.rb"
require "./snake.rb"

require "awesome_print"
require "curses"
require "logger"

# this enable this ruby script to be run from the command line
Sandbox.new.exp4 if __FILE__ == $PROGRAM_NAME

class Sandbox
  
  SNAKE_CHAR = "#{0x2588.chr(Encoding::UTF_8)}"
  
  def initialize
    @log = Logger.new("./logs/sandbox-debug.log") 
  end  
  
  def exp1
    Curses.init_screen
    Window.nodelay = true
    
    begin
      x = Curses.cols / 2  # We will center our text
      y = Curses.lines / 2

      Curses.setpos(y, x)
      Curses.addstr("Enter key: ")
      Curses.refresh
#      result = Curses.getch
      
#      @log.debug "@DEBUG L:#{__LINE__}   #{result}"
#      @log.debug "@DEBUG L:#{__LINE__}   #{Curses::KEY_UP}"
#      @log.debug "@DEBUG L:#{__LINE__}   #{Curses::KEY_DOWN}"

      input = nil    
      while true
        result = Curses.getch

        @log.debug "@DEBUG L:#{__LINE__}   input='#{input}'"
        break if result == 'x'
      end    

    ensure
      Curses.close_screen
    end
  end  
  
  # figure out how to get input from the keyboard
  def exp2
    Curses.init_screen
    Curses.curs_set(0)
    Curses.init_screen
    Curses.start_color
    Curses.noecho
    begin
      win = Curses.stdscr
      win.nodelay = true
      @log.debug "@DEBUG L:#{__LINE__}   win.class=#{win.class}"
    
    
      x = win.maxx / 2
      y = win.maxy / 2
      win.setpos(y, x)
      win.addstr("Enter key: ")
      win.refresh
      
      input = nil    
      while true
        input = win.getch

        if input == 'x'
          @log.debug "@DEBUG L:#{__LINE__}   inputed 'x' input='#{input}'" 
          break
        elsif input == 'a'
          @log.debug "@DEBUG L:#{__LINE__}   inputed 'a' input='#{input}'" 
        elsif input == 'd'
          @log.debug "@DEBUG L:#{__LINE__}   inputed 'd' input='#{input}'" 
        elsif input == 'w'
          @log.debug "@DEBUG L:#{__LINE__}   inputed 'w' input='#{input}'" 
        elsif input == 's'
          @log.debug "@DEBUG L:#{__LINE__}   inputed 's' input='#{input}'" 
        end     
             
             
      end 
      
    ensure
      Curses.close_screen
    end  
  end 

  def exp3
    Curses.init_screen
#   Curses.curs_set(0)
    Curses.init_screen
    Curses.start_color
#   Curses.noecho
    
    begin
      win = Curses.stdscr
#     win.nodelay = true
      @log.debug "@DEBUG L:#{__LINE__}   win.class=#{win.class}"
    
    
      x = win.maxx / 2
      y = win.maxy / 2
      win.setpos(y, x)
      win.addstr("LINE")
      
      win.setpos(y+1, x)
      win.addstr("#{0x2588.chr('UTF-8')}")

      win.setpos(y+2, x)
      win.addstr("#{0x2588.chr(Encoding::UTF_8)}")
      win.setpos(y+2, x+1)
      win.addstr("#{0x2588.chr(Encoding::UTF_8)}")
      win.setpos(y+2, x+2)
      win.addstr("#{0x2588.chr(Encoding::UTF_8)}")
      win.setpos(y+2, x+3)
      win.addstr("#{0x2588.chr(Encoding::UTF_8)}")

      win.setpos(y+3, x)
      win.addstr("LINE")

      win.refresh
      win.getch
    ensure
      Curses.close_screen
    end
  end  
  
  def main
    snake = Snake.new(0, 0, Snake::FACING_EAST)
    snake.report

    snake.move
    snake.move
    snake.move
    puts "@DEBUG L:#{__LINE__}    #{ap snake}"
    
    snake.turn_right
    puts "@DEBUG L:#{__LINE__}    #{ap snake}"
    
    snake.move
    snake.move
    snake.move
    snake.move
    puts "@DEBUG L:#{__LINE__}    #{ap snake}"
  end
  
  def exp4
    Curses.init_screen
    Curses.curs_set(0)
    Curses.init_screen
    Curses.start_color
    Curses.noecho
    
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
          @log.debug "@DEBUG L:#{__LINE__}   exiting..."
          break
        elsif input == 'w' or input == Curses::Key::UP
          @log.debug "@DEBUG L:#{__LINE__}   'w' pressed..."
          case snake.orientation
          when :east
            snake.turn_left
          when :west
            snake.turn_right  
          end

        elsif input == 's' or input == Curses::Key::DOWN
          @log.debug "@DEBUG L:#{__LINE__}   's' pressed..."
          case snake.orientation
          when :east
            snake.turn_right
          when :west
            snake.turn_left
          end

        elsif input == 'a' or input == Curses::Key::LEFT
          @log.debug "@DEBUG L:#{__LINE__}   'a' pressed..."
          case snake.orientation
          when :north
            snake.turn_left
          when :south
            snake.turn_right  
          end

        elsif input == 'd' or input == Curses::Key::RIGHT
          @log.debug "@DEBUG L:#{__LINE__}   'd' pressed..."
          case snake.orientation
          when :north
            snake.turn_right
          when :south
            snake.turn_left  
          end
        end

        snake.move
        win.setpos(snake.y_pos, snake.x_pos)

=begin
        crash = if win.inch != 32
            true
          elsif snake.orientation == Snake::FACING_NORTH and snake.y_pos < 0 + 1
            true
          elsif snake.orientation == Snake::FACING_EAST and snake.x_pos > win.maxx - 1
            true
          elsif snake.orientation == Snake::FACING_SOUTH and snake.y_pos > win.maxy - 1
            true
          elsif snake.orientation == Snake::FACING_WEST and snake.y_pos < 0 + 1
            true
          end
=end
        crash = snake_crashed?(snake, win)  
        if crash
          @log.debug "@DEBUG L:#{__LINE__}   Snake crashed..."
          exit 
        end

        win.addstr(SNAKE_CHAR)
        win.refresh
        
        sleep(0.20)
      end 

    ensure
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
end
