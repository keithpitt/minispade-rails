module MinispadeRails
  class DirectiveProcessor < Sprockets::DirectiveProcessor

    def process_source
      super

      if @spades
        output = @spades.map do |spade|
          # Create a custom context for the spade require
          attributes = context.environment.attributes_for(spade)
          spade_context = context.environment.context_class.new(context.environment, attributes.logical_path, spade)

          # Add the minispade custom processor as the last item
          processors = [ *attributes.processors, MinispadeRails::Compiler ]

          # Remove the directive processors for the individual file
          processors.delete(Sprockets::DirectiveProcessor)

          # Evaluate the spade
          spade_context.evaluate(spade, :processors => processors)
        end

        # Prepend the requires
        @result = output.join("") + @result
      end

      @result
    end

    def process_require_spade_directive(path = ".")
      if relative?(path)
        root = pathname.dirname.join(path).expand_path

        unless (stats = stat(root)) && stats.directory?
          raise ArgumentError, "require_spade argument must be a directory"
        end

        context.depend_on(root)

        @spades ||= []
        each_entry(root) do |pathname|
          if pathname.to_s == self.file
            next
          elsif context.asset_requirable?(pathname)
            context.depend_on pathname
            @spades << pathname
          end
        end
      else
        # The path must be relative and start with a `./`.
        raise ArgumentError, "require_spade argument must be a relative path"
      end

      nil
    end

  end
end
