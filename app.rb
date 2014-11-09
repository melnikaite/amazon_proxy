#!/usr/bin/env ruby -I ../lib -I lib
require 'sinatra'
require 'aws-sdk-v1'
require 'sinatra/json'
require_relative 'helpers/app_helpers'
require_relative 'helpers/array_helpres'
require_relative 'routes'

if development?
  require 'byebug'
  require 'sinatra/reloader'
  also_reload 'routes'
  also_reload 'helpers/*.rb'
end
