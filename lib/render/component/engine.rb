class Render::Component::Engine < ::Rails::Engine
  initializer "eduk-view-render" do |app|
    ActionController::Base.send :include, Render::Component::Helper
    ActionController::Base.helper Render::Component::Helper
  end
end
