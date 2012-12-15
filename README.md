# Naturally

Natural sorting with support for legal document numbering. 
See [Counting to 10 in Californian](http://www.weblaws.org/blog/2012/08/counting-from-1-to-10-in-californian/)
for the motivations to make this library.

I got most of this code from an open source project, but I forget which. (!) I then made
a few changes to handle the particular types of numbers that come up in statutes, such
as *335.1, 336, 336a*, etc.


## Installation

Add this line to your application's Gemfile:

    gem 'naturally'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install naturally


## Usage

```Ruby
# Sort a simple array of strings
Naturally.sort(["1.1", "1.10", "1.2"])  # => ["1.1", "1.2", "1.10"]

# Sort an array of objects by one attribute
objects.sort_by{ |o| Naturally.normalize(o.number) }
Thing = Struct.new(:number, :name)
objects = [
  Thing.new('1.1', 'color'),
  Thing.new('1.2', 'size'),
  Thing.new('1.1.1', 'opacity'),
  Thing.new('1.1.2', 'lightness'),
  Thing.new('1.10', 'hardness'),
  Thing.new('2.1', 'weight'),
  Thing.new('1.3', 'shape')
  ]
sorted = objects.sort_by{ |o| Naturally.normalize(o.number) }
```

See [the spec for more examples](https://github.com/dogweather/naturally/blob/master/spec/naturally_spec.rb).


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
