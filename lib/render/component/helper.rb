module Render::Component
  module Helper

    def render_component(component, attributes = {})
      Client.new.obtain_component(component, attributes)
    end
    module_function :render_component
  end
end
