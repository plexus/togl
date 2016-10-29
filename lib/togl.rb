require "attribs"
require "togl/version"
require "rack/utils"

module Togl
  def self.config
    @config ||= Config.new
  end

  def self.configure(&block)
    @config ||= Config.new
    @config.instance_eval(&block)
  end

  def self.on?(feature)
    config.on?(feature)
  end

  def self.off?(feature)
    config.off?(feature)
  end
end

require "togl/feature"
require "togl/util"
require "togl/adapter"
require "togl/adapter/rack_session"
require "togl/config"
require "togl/rack/middleware"
