module Togl
  class Feature
    include Attribs.new(:name, :config, default: :off, strategies: [])

    def on?
      on = strategies.reduce(nil) do |memo, strategy|
        if [true, false].include?(memo)
          memo
        else
          strategy_on?(strategy)
        end
      end
      if on.nil?
        default.equal?(:on)
      else
        on
      end
    end

    def strategy_on?(strategy)
      config.fetch_strategy(strategy).call(name)
    end
  end
end
