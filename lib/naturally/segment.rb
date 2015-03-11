module Naturally
  # An entity which can be compared to other like elements for
  # sorting. It's an object representing
  # a value which implements the {Comparable} interface.
  class Segment
    include Comparable

    def initialize(v)
      @val = v
    end

    def <=>(other)
      to_array <=> other.to_array
    end

    def to_array
      if @val =~ /^(\p{Digit}+)(\p{Alpha}+)$/
        [$1.to_i, $2]
      elsif @val =~ /^(\p{Alpha}+)(\p{Digit}+)$/
        [$1, $2.to_i]
      elsif @val =~ /^\p{Digit}+$/
        [@val.to_i]
      else
        [@val]
      end
    end
  end
end
