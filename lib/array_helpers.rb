class Array
  def x
    self[0]
  end

  def y
    self[1]
  end
  
  def %(other)
    [(self.x - other.x).abs, (self.y - other.y).abs]
  end
  
  def /(other)
    [(self.x - other.x), (self.y - other.y)]
  end
end