module Togl
  class Adapter
    class RackSession < self
      def initialize
        super(:rack_session)
      end

      def call(name)
        features = Thread.current[:togl_session_features]
        features && features[name.to_s]
      end
    end
  end
end
