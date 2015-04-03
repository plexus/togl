require "rack/utils"
require "togl/rack/middleware"

module Togl
  module Strategy
    class RackSession
      def initialize(togl)
        @togl = togl
      end

      def call(name)
        Thread.current[:togl_session_features][name.to_s]
      end
    end
  end
end
