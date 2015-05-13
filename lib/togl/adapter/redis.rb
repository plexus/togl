module Togl
  class Adapter
    class Redis < self
      MAPPING = { "true" => true,
                  "false" => false }

      def initialize
        super(:redis)
      end

      def call(name)
        MAPPING[current_redis.get(key(name))]
      end

      def enable!(name)
        current_redis.set(key(name), true)
      end

      def disable!(name)
        current_redis.set(key(name), false)
      end

      def reset!(name)
        current_redis.del(key(name))
      end

      def key(name)
        "togl.feature:#{name}"
      end

      attr_writer :current_redis
      def current_redis
        @current_redis || Redis.current
      end
    end
  end
end
