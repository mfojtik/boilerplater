if RUBY_VERSION =~ /^1\.8/
  require 'rubygems'
  require 'require_relative'
end

require 'gist'
require 'ostruct'
require 'fileutils'
require 'open-uri'
require 'pp'

require_relative './parser.rb'

#BoilerPlater.setup do |b|
#  b.prefix = 'test/'
#end
