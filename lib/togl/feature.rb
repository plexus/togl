module Togl
  class Feature
    include Attribs.new(:name, :config, default: :off, adapters: [])

    def on?
      on = adapters.reduce(nil) do |memo, adapter|
        if [true, false].include?(memo)
          memo
        else
          adapter_on?(adapter)
        end
      end
      if on.nil?
        default.equal?(:on)
      else
        on
      end
    end

    def adapter_on?(adapter)
      config.fetch_adapter(adapter).call(name)
    end
  end
end
