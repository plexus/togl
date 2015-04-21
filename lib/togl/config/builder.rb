module Togl
  class Config
    class Builder
      def initialize(config, &block)
        @config = config
        instance_eval(&block)
      end

      def feature(name, opts = {})
        @config.add_feature(name, opts)
      end

      def adapter(name, callable)
        @config.add_adapter(name, callable)
      end

      def adapters(*adapters)
        @config.default_adapters = adapters
      end
    end
  end
end
