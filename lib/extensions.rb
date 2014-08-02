
class Array
  
  def hash_from(*keys)
    Hash[ keys.first(self.length).zip(self) ]
  end

end

class Hash

  def pick(*keys)
    self.select { |key, value| keys.include?(key) }
  end

end

class Numeric
  
  def limit(range)
    self > range.max ? range.max : self < range.min ? range.min : self
  end 

end

class Symbol 
  
  def camelize(pascal)
    self.to_s.split('_').map.with_index do |component, index| 
      !pascal && index == 0 ? component : component.capitalize 
    end.join('') 
  end

end

