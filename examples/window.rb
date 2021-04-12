require "curses"
require "logger"

@log = Logger.new("window-debug.log") 

Curses.init_screen
begin
@log.debug "@DEBUG L:#{__LINE__}    Curses.cols=#{Curses.cols}"
@log.debug "@DEBUG L:#{__LINE__}    Curses.lines=#{Curses.lines}"

  x = Curses.cols / 2  # We will center our text
  y = Curses.lines / 2
@log.debug "@DEBUG L:#{__LINE__}    x=#{x}"
@log.debug "@DEBUG L:#{__LINE__}    y=#{y}"
  
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