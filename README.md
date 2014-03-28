# Naturally
[![Gem Version](https://badge.fury.io/rb/naturally.png)](http://badge.fury.io/rb/naturally) [![Build Status](https://travis-ci.org/dogweather/naturally.png)](https://travis-ci.org/dogweather/naturally) [![Code Climate](https://codeclimate.com/github/dogweather/naturally.png)](https://codeclimate.com/github/dogweather/naturally)

Natural (version number) sorting with added support for legal document numbering.
See Jeff Atwood's [Sorting for Humans: Natural Sort Order](http://www.codinghorror.com/blog/2007/12/sorting-for-humans-natural-sort-order.html) and the Weblaws.org post [Counting to 10 in Californian](http://www.weblaws.org/blog/2012/08/counting-from-1-to-10-in-californian/)
for the motivations to make this library.

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

Usually the library is used to sort an array of objects:


```Ruby
      # Define a new simple object for storing Ubuntu versions
      UbuntuVersion = Struct.new(:name, :version)
      
      # Create an array
      releases = [
        UbuntuVersion.new('Saucy Salamander', '13.10'),
        UbuntuVersion.new('Raring Ringtail',  '13.04'),
        UbuntuVersion.new('Precise Pangolin', '12.04.4'),
        UbuntuVersion.new('Maverick Meerkat', '10.10'),
        UbuntuVersion.new('Quantal Quetzal',  '12.10'),
        UbuntuVersion.new('Lucid Lynx',       '10.04.4')
      ]
      
      # Sort by version number
      sorted = Naturally.sort_by(releases, :version)
      
      # Check what we have
      expect(sorted.map(&:name)).to eq [
        'Lucid Lynx',
        'Maverick Meerkat',
        'Precise Pangolin',
        'Quantal Quetzal',
        'Raring Ringtail',
        'Saucy Salamander'
      ]
```

See [the spec for more examples](https://github.com/dogweather/naturally/blob/master/spec/naturally_spec.rb) of what Naturally can sort.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
