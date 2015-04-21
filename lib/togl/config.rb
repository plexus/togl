module Togl
  class Config
    include Attribs.new(:features, :adapters, :default_adapters)
    attr_writer :default_adapters

    def initialize(args = {}, &block)
      super({features: [], adapters: Adapter.all, default_adapters: []}.merge(args))
      Builder.new(self, &block) if block_given?
    end

    def add_feature(name, opts = {})
      name = name.to_sym
      opts = {
        name: name,
        config: self,
        adapters: default_adapters
      }.merge(opts)
      features.push(Feature.new(opts))
      self
    end

    def add_adapter(name, callable)
      name = name.to_sym
      adapters.merge!(name => callable)
      self
    end

    def fetch(name)
      name = name.to_sym
      features.detect do |feature|
        feature.name.equal?(name)
      end
    end

    def fetch_adapter(name)
      adapters.fetch(name.to_sym)
    end

    def on?(name)
      fetch(name).on?
    end

    def rack_middleware
      Rack::Middleware
    end
  end
end
