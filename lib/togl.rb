require "attribs"
require "togl/version"
require "rack/utils"

module Togl
  def self.config
    @config ||= Config.new
  end

  def self.configure(&block)
    Config::Builder.new(config, &block)
    config
  end

  def on?(feature)
    config.on?(feature)
  end

  def off?(feature)
    config.on?(feature)
  end
end

require "togl/feature"
require "togl/util"
require "togl/adapter"
require "togl/adapter/rack_session"
require "togl/config"
require "togl/config/builder"
require "togl/rack/middleware"
