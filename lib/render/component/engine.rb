class Render::Component::Engine < ::Rails::Engine
  initializer "render-component" do |app|
    ActionController::Base.send :include, Render::Component::Helper
    ActionController::Base.helper Render::Component::Helper
  end
end
