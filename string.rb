class String
  
  def httpize
    
    "http://#{self}" unless self.match(/^http:\/\//)
    
  end

  def dehttpize
    
    self.gsub(/^http:\/\//, '')
    
  end
  
end
