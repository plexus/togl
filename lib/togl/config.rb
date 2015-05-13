module Togl
  class Config
    attr_accessor :features, :adapters, :default_adapters

    def initialize(args = {}, &block)
      @features = args.fetch(:features, [])
      @adapters = args.fetch(:adapters, {})
      @default_adapters = args[:default_adapters]

      instance_eval(&block) if block_given?
    end

    # Commands

    def feature(name, opts = {})
      name = name.to_sym
      opts = {
        name: name,
        config: self,
        adapters: default_adapters
      }.merge(opts)
      features.push(Feature.new(opts))
      self
    end

    def use(adapter)
      adapters[adapter.name] = adapter
      self
    end

    # Queries

    def default_adapters
      @default_adapters || adapters.keys
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

    def off?(name)
      !on?(name)
    end

    def rack_middleware
      Rack::Middleware
    end
  end
end
