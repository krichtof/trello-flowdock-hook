require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
require 'faraday'


require './app'
run App
