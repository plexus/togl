module Togl
  module Rack
    class Middleware
      SESSION_KEY = 'togl.features'

      def initialize(app)
        @app = app
      end

      def call(env)
        Thread.current[:togl_session_features] = detect_feature_params(env)
        @app.call(env).tap do
          Thread.current[:togl_session_features] = nil
        end
      end

      def detect_feature_params(env)
        params = ::Rack::Utils.parse_query(env["QUERY_STRING"])
        session = env["rack.session"]
        session[SESSION_KEY] ||= {}
        { ["enable_feature", "enable_features"]   => true,
          ["disable_feature", "disable_features"] => false,
          ["reset_feature", "reset_features"]     => nil }.each do |keys, flag|
          keys.each do |key|
            feature_names(params, key).each do |feature|
              session[SESSION_KEY][feature] = flag
            end
          end
        end
        session[SESSION_KEY]
      end

      def feature_names(params, key)
        params.fetch(key, "").split(",").map(&:strip)
      end
    end
  end
end
