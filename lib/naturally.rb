require 'naturally/segment'

# A module which performs natural sorting on a variety of number
# formats. (See the specs for examples.)
#
# It achieves this by capitalizing on Ruby's behavior when
# comparing arrays: The module sorts arrays of segmented numbers such as
# ['1.9', '1.9a', '1.10'] by comparing them in their array forms.
# I.e., approximately [['1', '9'], ['1, '9a'], ['1', '10']]
module Naturally
  # Perform a natural sort.
  #
  # @param [Array<String>] an_array the list of numbers to sort.
  # @return [Array<String>] the numbers sorted naturally.
  def self.sort(an_array)
    an_array.sort_by { |x| normalize(x) }
  end

  # Sort an array of objects "naturally" by a given attribute.
  #
  # @param [Array<Object>] an_array the list of objects to sort.
  # @param [Symbol] an_attribute the attribute by which to sort.
  # @return [Array<Object>] the objects in natural sort order.
  def self.sort_by(an_array, an_attribute)
    an_array.sort_by { |obj| normalize(obj.send(an_attribute)) }
  end

  # Convert the given number an array of {Segment}s.
  # This enables it to be sorted against other arrays
  # by the standard #sort method.
  #
  # For example:
  # '1.2a.3' becomes [Segment<'1'>, Segment<'2a'>, Segment<'3'>]
  #
  # @param [String] complex_number the number in a hierarchical form
  #                 such as 1.2a.3.
  # @return [Array<Segment>] an array of Segments which
  #         can be sorted naturally via a standard #sort.
  def self.normalize(complex_number)
    tokens = complex_number.to_s.scan(/\p{Word}+/)
    tokens.map { |t| Segment.new(t) }
  end
end
