module Togl
  class Adapter
    class RackSession < self
      def initialize
        super(:rack_session)
      end

      def call(name)
        Thread.current[:togl_session_features][name.to_s]
      end
    end
  end
end
