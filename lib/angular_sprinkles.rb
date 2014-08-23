module AngularSprinkles
  PREFIX = 'sprinkles'
  APP_NAME = "#{PREFIX}App"
  CONTROLLER_NAME = "#{PREFIX}Ctrl"
  CONTROLLER_FN = "window.#{CONTROLLER_NAME}Fn"
end

require 'angular_sprinkles/helpers'
require 'angular_sprinkles/decorators'
require 'angular_sprinkles/controller'
require 'angular_sprinkles/engine'
require 'angular_sprinkles/railtie'
