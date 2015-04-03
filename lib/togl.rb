require "attribs"
require "togl/version"

module Togl
  def self.config
    @config ||= Config.new
  end
end

require "togl/feature"
require "togl/util"
require "togl/config"
