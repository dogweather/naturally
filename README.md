# Naturally
[![Gem Version](https://badge.fury.io/rb/naturally.png)](http://badge.fury.io/rb/naturally) [![Build Status](https://travis-ci.org/dogweather/naturally.png)](https://travis-ci.org/dogweather/naturally) [![Code Climate](https://codeclimate.com/github/dogweather/naturally.png)](https://codeclimate.com/github/dogweather/naturally)

Natural (version number) sorting with added support for legal document numbering.
See [Sorting for Humans : Natural Sort Order](http://www.codinghorror.com/blog/2007/12/sorting-for-humans-natural-sort-order.html) and [Counting to 10 in Californian](http://www.weblaws.org/blog/2012/08/counting-from-1-to-10-in-californian/)
for the motivations to make this library. This is also the kind of ordering you want if you're sorting version numbers.

The core of the search is [from here](https://github.com/ahoward/version_sorter). I then made
several changes to handle the particular types of numbers that come up in statutes, such
as *335.1, 336, 336a*, etc.

`Naturally` will also sort "numbers" in college course code format such as
*MATH101, MATH102, ...*. See the specs for examples.


## Installation

Add this line to your application's Gemfile:

    gem 'naturally'

And then execute:

    $ bundle

Or install it outside of bundler with:

    $ gem install naturally


## Usage

```Ruby
require 'naturally'

# Sort a simple array of strings
Naturally.sort(["1.1", "1.10", "1.2"])  # => ["1.1", "1.2", "1.10"]
```

Usually, however, the library is used to sort an array of some kind of
object:


```Ruby
# Sort an array of objects by one attribute
Place = Struct.new(:number, :name)
places = [
  Place.new('1',     'USA'),
  Place.new('2',     'Canada'),
  Place.new('1.1',   'Oregon'),
  Place.new('1.2',   'Washington'),
  Place.new('1.1.1', 'Portland'),
  Place.new('1.10',  'Texas'),
  Place.new('2.1',   'British Columbia'),
  Place.new('1.3',   'California'),
  Place.new('1.1.2', 'Eugene')
  ]
Naturally.sort_by(places, :number)  # =>

[<struct Place number="1",     name="USA">,
 <struct Place number="1.1",   name="Oregon">,
 <struct Place number="1.1.1", name="Portland">,
 <struct Place number="1.1.2", name="Eugene">,
 <struct Place number="1.2",   name="Washington">,
 <struct Place number="1.3",   name="California">,
 <struct Place number="1.10",  name="Texas">,
 <struct Place number="2",     name="Canada">,
 <struct Place number="2.1",   name="British Columbia">]
```

See [the spec for more examples](https://github.com/dogweather/naturally/blob/master/spec/naturally_spec.rb).


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
