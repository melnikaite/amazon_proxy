require 'rack/test'
require File.expand_path('../../proxy', __FILE__)

module RackSpecHelpers
  include Rack::Test::Methods
  attr_accessor :app
end
