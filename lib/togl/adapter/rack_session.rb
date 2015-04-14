module Togl
  class Adapter
    class RackSession < self
      register :rack_session, self

      def self.call(name)
        Thread.current[:togl_session_features][name.to_s]
      end
    end
  end
end
