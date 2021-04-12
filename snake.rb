class Snake
  
  FACING_NORTH = :north 
  FACING_EAST  = :east
  FACING_SOUTH = :south
  FACING_WEST  = :west
  
  attr_reader :x_pos
  attr_writer :x_pos  
  
  attr_reader :y_pos
  attr_writer :y_pos
  
  attr_reader :facing
  attr_writer :facing
  
end 