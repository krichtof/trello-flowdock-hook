require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
require 'faraday'

require 'json'

$: << File.dirname(__FILE__)
$: << File.join(File.dirname(__FILE__), "lib")

require './init.rb'

require 'app'
run App
