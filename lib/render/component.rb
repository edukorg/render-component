require "render/component/version"
require "render/component/configuration"
require "render/component/helper"
require "render/component/client"

module Render
  module Component
    def self.configuration
      @configuration ||= Configuration.new
    end

    class Error < StandardError
    end
  end
end
