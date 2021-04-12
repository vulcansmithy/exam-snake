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
  
end 