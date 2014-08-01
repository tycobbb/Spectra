Spectrum
========
Keep your app's colors in-sync between InterfaceBuilder and code!


Command-line utility which uses a Ruby DSL to synchronize color palettes, Objective-C UIColor categories, and Swift UIColor extensions. Define a colors.rb file and execute the spectrum command from the same directory to generate the output files.

## DSL Overview

Specifying a class/method prefix (required):
```ruby
prefix :spc # subsitute your prefix as desired
```

Specifying output formats (optional, defaults to `:palette` and `:objc`):
```ruby
formats :palette, :swift
format  :objc, 'path/to/categories'
```

Specifying colors (optional, but it's pretty pointless not to):
```ruby
color :red,    (components 255, 0, 0)
color :gray,   (hex 0xEEEEEE 0.6)
color :white,  (white 1.0)
color :overlay (components 0.8, 0.7, 0.2, 0.75)

## alternate syntax

color :red,     r: 255
color :gray,    hex: 0xEEEEEE, a: 0.6
color :white,   w: 1.0
color :overlay, r: 0.8, g: 0.7, b: 0.2, a: 0.75
```
