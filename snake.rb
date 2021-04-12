class Snake
  
  FACING_NORTH = :north 
  FACING_EAST  = :east
  FACING_SOUTH = :south
  FACING_WEST  = :west
  
  attr_reader :x_pos
  attr_writer :x_pos  
  
  attr_reader :y_pos
  attr_writer :y_pos
  
  attr_reader :orientation
  attr_writer :orientation
  
  attr_reader :boundary_x
  attr_writer :boundary_y
  
  
  def initialize(x, y, orientation, boundary_x, boundary_y)
    self.x_pos = x
    self.y_pos = y
    self.orientation = orientation
    self.boundary_x = boundary_x
    self.boundary_y = boundary_y
  end  
  
  def turn_left
    case self.orientation
    when :north
      self.orientation = FACING_WEST
    when :east
      self.orientation = FACING_NORTH
    when :south
      self.orientation = FACING_EAST
    when :west       
      self.orientation = FACING_SOUTH 
    end  
  end
  
  def turn_right
    case self.orientation
    when :north
      self.orientation = FACING_EAST
    when :east
      self.orientation = FACING_SOUTH 
    when :south
      self.orientation = FACING_WEST
    when :west       
      self.orientation = FACING_NORTH
    end  
  end
  
  def report
    puts "#{self.x_pos}, #{self.x_pos}, #{self.orientation}"
  end
  
  def move
    case self.orientation
    when :north
      self.x_pos += 1 #if self.x_pos < 4
    when :east
      self.y_pos += 1 #if self.y_pos < 4
    when :south
      self.x_pos -= 1 #if self.x_pos > 0
    when :west
      self.y_pos -= 1 #if self.y_pos > 0 
    end      
  end 
  
end 