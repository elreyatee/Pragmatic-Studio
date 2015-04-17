require_relative 'auditable'

class LoadedDie
  include Auditable
  
  attr_reader :number

  def roll
    numbers = [1, 1, 2, 5, 6, 6]
    @number = numbers.sample
    audit
    return @number
  end
end
