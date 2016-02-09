$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require "rack"
require "web_app"
require "web_display"

display = WebDisplay.new 
run WebApp.new(GameController.new(WebPlayerFactory.new(display)), display).app_router
