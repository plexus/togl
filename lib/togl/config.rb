module Togl
  class Config
    include Attribs.new(:features, :strategies, :default_strategies)
    attr_writer :default_strategies

    def initialize(args = {}, &block)
      super({features: [], strategies: {}, default_strategies: []}.merge(args))
      Builder.new(self, &block) if block_given?
    end

    def with_feature(name, opts = {})
      name = name.to_sym
      opts = {
        name: name,
        config: self,
        strategies: default_strategies
      }.merge(opts)
      features.push(Feature.new(opts))
      self
    end

    def with_strategy(name, callable)
      name = name.to_sym
      strategies.merge!(name => callable)
      self
    end

    def fetch(name)
      name = name.to_sym
      features.detect do |feature|
        feature.name.equal?(name)
      end
    end

    def fetch_strategy(name)
      strategies.fetch(name.to_sym)
    end

    def on?(name)
      fetch(name).on?
    end

    def rack_middleware
      Rack::Middleware::Factory.new(self)
    end

    class Builder
      def initialize(config, &block)
        @config = config
        instance_eval(&block)
      end

      def feature(name, opts = {})
        @config.with_feature(name, opts)
      end

      def strategies(*names)
        names.each do |name|
          require "togl/strategy/#{name}"
          @config.with_strategy(
            name,
            Togl::Strategy.const_get(Util.camelize(name.to_s)).new(@config)
          )
        end
        @config.default_strategies = names.map(&:to_sym)
      end
    end
  end
end
