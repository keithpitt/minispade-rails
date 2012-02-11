require 'tilt/template'

module MinispadeRails

  # = Sprockets engine for HandlebarsJS templates
  class Compiler < Tilt::Template

    def self.default_mime_type
      'application/javascript'
    end

    def initialize_engine
    end

    def prepare
    end

    def evaluate(scope, locals, &block)
      "minispade.register(\"#{scope.logical_path}\", #{data.inspect});\n"
    end

  end

end
