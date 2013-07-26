require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
require 'faraday'

require 'json'

require './app'
run App
