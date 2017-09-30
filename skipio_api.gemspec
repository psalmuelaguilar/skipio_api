lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'skipio_api'
  spec.version       = '0.0.3'
  spec.authors       = ['Psalmuel Aguilar']
  spec.email         = ['psalmuelaguilar@gmail.com']
  spec.summary       = 'Skipio Api'
  spec.description   = 'API Communication for Skipio'
  spec.license       = 'MIT'
  spec.files         = ['lib/skipio.rb']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'addressable'
end
