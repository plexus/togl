module Togl
  class Feature
    include Attribs.new(:name, :config, strategies: [])

    def on?
    end
  end
end
