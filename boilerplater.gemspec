lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "boilerplater"
  s.version     = '0.2'
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.authors     = ["Michal Fojtik"]
  s.email       = ["mi@mifo.sk"]
  s.homepage    = "http://github.com/mifo/boilerplater"
  s.summary     = "Simple boiler plate system to bootstrap dev of new applications"
  s.description = "Speed up your development using prepared boiler plate templates"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "gist"

  s.files        = Dir.glob("{bin,lib}/**/*")
  s.executables  = ['bp']
  s.require_path = 'lib'
end

