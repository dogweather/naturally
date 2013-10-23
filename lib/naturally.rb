require "naturally/version"

module Naturally
  
  # Perform a natural sort.
  # @param [Array<String>] an_array the list of numbers to sort.
  # @return [Array<String>] the numbers sorted naturally.
  def self.sort(an_array)
    return an_array.sort_by{ |x| normalize(x) }
  end  

  # Convert the given number into an object that can be sorted
  # naturally. 
  # @param [String] number the number in complex form such as 1.2a.3.
  # @return [Array<NumberElement>] an array of NumberElements which is
  #         able to be sorted naturally via a normal 'sort'.
  def self.normalize(number)
    number.to_s.scan(%r/[0-9a-zA-Z]+/o).map{|i| NumberElement.new(i)}
  end


  private

  class NumberElement
    include Comparable
    attr_accessor :val

    def initialize(v)
      @val = v
    end

    def <=>(other)
      if pure_integer? && other.pure_integer?
        return @val.to_i <=> other.val.to_i
      elsif numbers_with_letters? || other.numbers_with_letters?
        return simple_normalize(@val) <=> simple_normalize(other.val)
      elsif letters_with_numbers? || other.letters_with_numbers?
        return reverse_simple_normalize(@val) <=> reverse_simple_normalize(other.val)
      else
        return @val <=> other.val
      end
    end
    
    def pure_integer?
      @val =~ /^\d+$/
    end
    
    def numbers_with_letters?
      val =~ /^\d+[a-zA-Z]+$/
    end

    def letters_with_numbers?
      val =~ /^[a-zA-Z]+\d+$/
    end
    
    def simple_normalize(n)
      if n =~ /^(\d+)([a-zA-Z]+)$/
        return [$1.to_i, $2]
      else 
        return [n.to_i]
      end
    end

    def reverse_simple_normalize(_value)
      if _value =~ /^([a-zA-Z]+)(\d+)$/
        return [$1, $2.to_i]
      else
        return [_value.to_s]
      end
    end
  end
  
end
