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
      a = to_array
      b = other.to_array

      # if an integer segment is compared to a string segment, <=> will fail
      # in this case converting an integer to a string will give desired results
      array_size = [a.size, b.size].max
      for i in 0..array_size
        if(a[i].class == String || b[i].class == String)
          a[i] = a[i].to_s
          b[i] = b[i].to_s
        end
      end

      a <=> b
    end

    # @return [Array] a representation of myself in array form
    #                 which enables me to be compared against
    #                 another instance for sorting.
    #
    # @example a simple number
    #   Segment.new('10').to_array #=> [10]
    #
    # @example a college course code
    #   Segment.new('MATH101').to_array #=> ["MATH", 101]
    #
    # @example Section 633a of the ADEA
    #   Segment.new('633a').to_array #=> [633, "a"]
    def to_array
      # TODO: Refactor, probably via polymorphism
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
