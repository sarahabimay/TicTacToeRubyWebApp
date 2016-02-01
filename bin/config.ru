#!/usr/bin/env ruby
require 'rack'
require 'pry-byebug'
$LOAD_PATH << File.expand_path("../../lib", __FILE__)
require 'web_app'
run WebApp.new.app_router
