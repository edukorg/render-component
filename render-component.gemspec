# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'render/component/version'

Gem::Specification.new do |spec|
  spec.name          = "render-component"
  spec.version       = Render::Component::VERSION
  spec.authors       = ["Lucas Gomide"]
  spec.email         = ["lucaslg200@gmail.com"]

  spec.summary       = %q{Render Components via API}
  spec.description   = %q{}
  spec.homepage      = "http://eduk.com.br"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "curb", "~> 0.9.3"
  spec.add_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
