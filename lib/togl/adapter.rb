module Togl
  class Adapter
    def self.all
      @all ||= {}
    end

    def self.register(name, callable)
      Adapter.all[name] = callable
    end
  end
end
