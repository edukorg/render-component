# encoding: UTF-8

module Render::Component
  module Helper

    def render_component(component, attributes = {})
      Client.new.obtain_component(component, attributes).force_encoding(Encoding::UTF_8)
    end
    module_function :render_component
  end
end
