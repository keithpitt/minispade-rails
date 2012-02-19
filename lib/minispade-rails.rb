require 'sprockets'
require 'sprockets/engines'

require 'minispade-rails/directive_processor'
require 'minispade-rails/compiler'
require 'minispade-rails/railtie'
require "minispade-rails/version"

module MinispadeRails
  Sprockets.register_engine '.spade', MinispadeRails::Compiler
end
