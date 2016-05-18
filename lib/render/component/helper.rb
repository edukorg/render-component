module Render::Component
  module Helper

    def render_component(component)
      Client.new.obtain_component(component)
    end
    module_function :render_component
  end
end
