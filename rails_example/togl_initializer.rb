# initializer

require 'togl'

Togl.configure do
  use Togl::Adapter::RackSession.new
  use Class.new(Togl::Adapter) {
    def call(name)
      Rails.cache.fetch("feature_#{name}") do
        Feature.where(name: name).pluck(:enabled).first
      end
    end
  }.new(:db)

  feature :raffle_on
end
