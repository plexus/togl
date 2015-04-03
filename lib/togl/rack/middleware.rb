module Togl
  module Rack
    class Middleware
      def initialize(app, togl)
        @app = app
        @togl = togl
      end

      def call(env)
        Thread.current[:togl_session_features] = detect_feature_params(env)
        @app.call(env)
        Thread.current[:togl_session_features] = nil
      end

      def detect_feature_params(env)
        params = ::Rack::Utils.parse_query(env["QUERY_STRING"])
        session = env["rack.session"]
        session_features = session["features"] || {}
        { ["enable_feature", "enable_features"]   => true,
          ["disable_feature", "disable_features"] => false,
          ["reset_feature", "reset_features"]     => nil }.each do |keys, flag|
          keys.each do |key|
            feature_names(params, key).each do |feature|
              session_features[feature] = flag
            end
          end
        end
        session_features
      end

      def feature_names(params, key)
        params.fetch(key, "").split(",").map(&:strip)
      end

      class Factory
        def initialize(togl)
          @togl = togl
        end

        def new(app)
          Middleware.new(app, @togl)
        end
      end
    end
  end
end
