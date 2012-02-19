module MinispadeRails
  class Railtie < Rails::Engine

    initializer :setup_minispade do |app|
      app.assets.register_preprocessor 'application/javascript', MinispadeRails::DirectiveProcessor
    end

  end
end
