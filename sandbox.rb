require "curses"
require "logger"

@log = Logger.new("./logs/sandbox-debug.log") 

Curses.init_screen
begin
  nb_lines = Curses.lines
  nb_cols = Curses.cols
  
ensure
  Curses.close_screen
end

@log.debug "@DEBUG L:#{__LINE__}    Number of rows: #{nb_lines}"
@log.debug "@DEBUG L:#{__LINE__}    Number of columns: #{nb_cols}"
