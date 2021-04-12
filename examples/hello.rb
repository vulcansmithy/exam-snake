#!/usr/bin/env ruby

require "curses"
require "logger"

def show_message(message)
  @log.debug "@DEBUG L:#{__LINE__}    MARKED"
  
  height = 5
  width  = message.length + 6
  top    = (Curses.lines - height) / 2
  left   = (Curses.cols - width) / 2
  win = Curses::Window.new(height, width, top, left)
  win.box("|", "-")
  win.setpos(2, 3)
  win.addstr(message)
  win.refresh
  win.getch
  win.close
end

# initialize logger
@log = Logger.new("./hello-debug.log") 

Curses.init_screen
begin
@log.debug "@DEBUG L:#{__LINE__}    MARKED"
Curses.crmode
  Curses.setpos((Curses.lines - 1) / 2, (Curses.cols - 11) / 2)
  Curses.addstr("Hit any key")
  Curses.refresh
  Curses.getch
  show_message("Hello, World!")
ensure
  Curses.close_screen
end