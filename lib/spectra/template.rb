
## replace with your desired class/method prefix (used where applicable)
prefix :foo 

## specifiy the output formats using `format <type> [<output-path]`
format :palette
format :objc, 'path/to/categories'

## customize the name generation for a specific format
# format :objc do |name, prefix|
#   name.camelize(true)
# end

## specify the colors to generate 
color :red,   (components 255, 0, 0, 1.0)
color :gray,  (white 0.5, 1.0)
color :green, (hex 0x00ff00, 1.0)

