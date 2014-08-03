Spectra
========
Keep app-specific colors in-sync across all your tools with a single specification!

Spectra is a command-line utility and Ruby DSL that generates color palettes (.clr), Objective-C categories, and Swift extensions. Define a spectrum.rb file and then run spectra from the terminal. That's all there is to it.

## Using the DSL: spectrum.rb

Specifying a class/method prefix (required):
```ruby
prefix :spc # subsitute your desired prefix
```

Specifying output formats (optional, defaults to `:palette` and `:objc`):
```ruby

## if you don't care about options
formats :palette, :swift

## if you want to specify the output directory
format :objc, 'path/to/categories'

## if you want to customize the method/color names
format :swift, 'path/to/extensions' do |name, prefix|
  name.camelize(true) # SyntacticRogueRed
end
```

Specifying colors (optional, but it's pretty pointless not to):
```ruby
color :red,    (components 255, 0, 130)
color :gray,   (hex 0xEEEEEE 0.6)
color :white,  (white 1.0)
color :overlay (components 0.8, 0.7, 0.2, 0.75)

## alternate syntax

color :red,     red: 255, blue: 130
color :gray,    hex: 0xEEEEEE, a: 0.6
color :white,   w: 1.0
color :overlay, r: 0.8, g: 0.7, b: 0.2, a: 0.75
```

## Installation

Spectra is published as a Rubygem. Install with `gem`: 
```ruby
gem install spectra
```

Or `bundler`:
```ruby
gem 'spectra', '~> 0.1.1'
```

