require 'tilt/template'

module MinispadeRails

  # = Sprockets engine for Minispade templates
  class Compiler < Tilt::Template

    def self.default_mime_type
      'application/javascript'
    end

    def initialize_engine
    end

    def prepare
    end

    def evaluate(scope, locals, &block)
      if MinispadeRails::Config.deferred
        "minispade.register(\"#{scope.logical_path}\", #{data.inspect});\n"
      else
        "minispade.register(\"#{scope.logical_path}\", function() { #{data} });\n"
      end
    end

  end

end
