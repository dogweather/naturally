module Naturally
  # An entity which can be compared to other like elements for
  # sorting. It's an object representing
  # a value which implements the {Comparable} interface which can
  # convert itself to an array.
  class Segment
    include Comparable

    def initialize(v, collator = nil)
      @val = v
      @collator = collator
    end

    def <=>(other)
      other_array = other.to_array

      if @collator
        compare_using_collator_for_strings(to_array, other_array)
      else
        to_array <=> other.to_array
      end
    end

    # @return [Array] a representation of myself in array form
    #                 which enables me to be compared against
    #                 another instance for sorting.
    #                 The array is prepended with a symbol so
    #                 two arrays are always comparable.
    #
    # @example a simple number
    #   Segment.new('10').to_array #=> [:int, 10]
    #
    # @example a college course code
    #   Segment.new('MATH101').to_array #=> [:str, "MATH", 101]
    #
    # @example Section 633a of the U.S. Age Discrimination in Employment Act
    #   Segment.new('633a').to_array #=> [:int, 633, "a"]
    def to_array
      # TODO: Refactor, probably via polymorphism
      if @val =~ /^(\p{Digit}+)(\p{Alpha}+)$/
        [:int, $1.to_i, $2]
      elsif @val =~ /^(\p{Alpha}+)(\p{Digit}+)$/
        [:str, $1, $2.to_i]
      elsif @val =~ /^\p{Digit}+$/
        [:int, @val.to_i]
      else
        [:str, @val]
      end
    end

    private

    # Compare to arrays according to the rules of Ruby, using a collator to
    # compare String elements.
    # https://github.com/ruby/ruby/blob/v3_0_1/array.c#L5173-L5210
    #
    # call-seq:
    #   array <=> other_array -> -1, 0, or 1
    #
    # Returns -1, 0, or 1 as +self+ is less than, equal to, or greater than +other_array+.
    # For each index +i+ in +self+, evaluates <tt>result = self[i] <=> other_array[i]</tt>.
    #
    # Returns -1 if any result is -1:
    #   [0, 1, 2] <=> [0, 1, 3] # => -1
    #
    # Returns 1 if any result is 1:
    #   [0, 1, 2] <=> [0, 1, 1] # => 1
    #
    # When all results are zero:
    # - Returns -1 if +array+ is smaller than +other_array+:
    #     [0, 1, 2] <=> [0, 1, 2, 3] # => -1
    # - Returns 1 if +array+ is larger than +other_array+:
    #     [0, 1, 2] <=> [0, 1] # => 1
    # - Returns 0 if +array+ and +other_array+ are the same size:
    #     [0, 1, 2] <=> [0, 1, 2] # => 0
    #
    def compare_using_collator_for_strings(array_1, array_2)
      cmp = 0

      array_1.each_with_index do |element, index|
        next unless index < array_2.length

        case element
        when Integer, Symbol
          cmp = element <=> array_2[index]
        when String
          cmp = @collator.compare(element, array_2[index])
        else
          raise ArgumentError, "Cannot compare #{e.class} with #{array_2[index].class}"
        end

        break if cmp != 0
      end

      return cmp unless cmp == 0

      length_difference = array_1.length - array_2.length

      return 0 if length_difference == 0
      return 1 if length_difference > 0
      return -1
    end
  end
end
