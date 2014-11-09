require 'rack/test'
require File.expand_path('../../app', __FILE__)

module RackSpecHelpers
  include Rack::Test::Methods
  attr_accessor :app
end
