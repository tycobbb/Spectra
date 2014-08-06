
## replace with your desired class/method prefix (used where applicable)
prefix :foo 

## Formats

## specify formats with `format` or `formats`
format :palette

## replace path with your own personal category directory
format :objc, 'path/to/categories'

## uncomment to customize the naming scheme for a particulary format
# format :objc do |name, prefix|
#   name.camelize(true)
# end

## Colors

## note: the last component is always alpha, and can safely be omitted
color :red,   (components 255, 0, 0, 1.0)
color :gray,  (white 0.5, 1.0)
color :green, (hex 0x00ff00, 1.0)

