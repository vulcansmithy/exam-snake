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
    @log = Logger.new("sandbox-debug.log") 
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
      win.nodelay = true
      
      initial_x = win.maxx / 2
      initial_y = win.maxy / 2
      snake = Snake.new(initial_x, initial_y, Snake::FACING_EAST, win.maxx, win.maxy)
      
      win.setpos(snake.y_pos, snake.x_pos)
      win.addstr("#{0x2588.chr(Encoding::UTF_8)}")
      win.refresh
      
      input = nil    
      while true
        input = win.getch

        if input == 'x'
          @log.debug "@DEBUG L:#{__LINE__}   inputed 'x, exiting...'" 
          break
        end    
        
        case snake.orientation
        when :north
          if input == 'a'
            snake.turn_left
          elsif input == 'd'
            snake.turn_right
          else
            snake.move
            win.setpos(snake.y_pos, snake.x_pos)
            win.addstr(SNAKE_CHAR)
            win.refresh
          end     
        when :east
          
          if input == 'w'
@log.debug "@DEBUG L:#{__LINE__}  x=#{snake.x_pos}, y=#{snake.y_pos} #{snake.orientation}" 
            snake.turn_left
            snake.move
@log.debug "@DEBUG L:#{__LINE__}  x=#{snake.x_pos}, y=#{snake.y_pos} #{snake.orientation}"   
            
@log.debug "@DEBUG L:#{__LINE__}   MARKED" 
            win.setpos(snake.y_pos, snake.x_pos)
@log.debug "@DEBUG L:#{__LINE__}   MARKED" 
            win.addstr(SNAKE_CHAR)
@log.debug "@DEBUG L:#{__LINE__}   MARKED" 
            win.refresh
@log.debug "@DEBUG L:#{__LINE__}   MARKED"             
            
          elsif input == 's'
            snake.turn_right
          else
@log.debug "@DEBUG L:#{__LINE__}   ***MARKED***"               
            snake.move
            win.setpos(snake.y_pos, snake.x_pos)
            win.addstr(SNAKE_CHAR)
            win.refresh
          end 
        when :south
          if input == 'a'
            snake.turn_right
          elsif input == 'd'
            snake.turn_left
          end 
        when :west
          if input == 'w'
            snake.turn_right
          elsif input == 's'
            snake.turn_left
          end 
        end    
        
        sleep(1)
=begin            
        snake.move
        sleep(1)     
             
        win.setpos(snake.x_pos, snake.y_pos)
        win.addstr(SNAKE_CHAR)
        win.refresh   
=end
      end 
      
      
    ensure
      Curses.close_screen
    end    
  end
end
