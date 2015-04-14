module Togl
  class Config
    class Builder
      def initialize(config, &block)
        @config = config
        instance_eval(&block)
      end

      def feature(name, opts = {})
        @config.with_feature(name, opts)
      end

      def adapter(name, callable)
        @config.with_adapter(name, callable)
      end

      def adapters(*adapters)
        @config.default_adapters = adapters
      end
    end
  end
end
