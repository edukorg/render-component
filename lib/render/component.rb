require "render/component/version"
require "render/component/configuration"
require "render/component/helper"
require "render/component/client"
require "render/component/engine" if defined?(Rails)

module Render
  module Component
    def self.configuration
      @configuration ||= Configuration.new
    end

    class Error < StandardError
    end
  end
end
