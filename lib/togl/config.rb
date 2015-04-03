module Togl
  class Config
    include Attribs.new(:features, :strategies, :default_strategies)

    def initialize(args = {})
      super({features: [], strategies: {}, default_strategies: []}.merge(args))
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

    def strategy(name)
      strategies.fetch(name.to_sym)
    end

    def on?(name)
      fetch(name).on?
    end
  end
end
