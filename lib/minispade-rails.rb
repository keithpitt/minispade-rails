require 'sprockets'
require 'sprockets/engines'

require "minispade-rails/version"
require 'minispade-rails/compiler'

module MinispadeRails
  class Engine < Rails::Engine
  end

  Sprockets.register_engine '.js', Compiler
end
