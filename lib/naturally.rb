require "naturally/version"

module Naturally
  
  # @return [Array] of strings sorted as if they
  # were numbers.
  def self.sort(an_array)
    return an_array.sort_by{ |x| normalize(x) }
  end
  
  
  private

  def self.normalize(version)
    version.to_s.scan(%r/[0-9a-zA-Z]+/o).map{|i| NumberElement.new(i)}
  end

  class NumberElement
    include Comparable
    attr_accessor :val

    def initialize(v)
      @val = v
    end

    def <=>(other)
      if pure_integer? && other.pure_integer?
        return @val.to_i <=> other.val.to_i
      elsif mixed? || other.mixed?
        return simple_normalize(@val) <=> simple_normalize(other.val)
      else
        return @val <=> other.val
      end
    end
    
    def pure_integer?
      @val =~ /^\d+$/
    end
    
    def mixed?
      val =~ /^\d+[a-zA-Z]+$/
    end
    
    def simple_normalize(n)
      if n =~ /^(\d+)([a-zA-Z]+)$/
        return [$1.to_i, $2]
      else 
        return [n.to_i]
      end
    end    
  end
  
end
