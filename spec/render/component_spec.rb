require 'spec_helper'

describe Render::Component do
  it 'has a version number' do
    expect(Render::Component::VERSION).not_to be nil
  end

  it 'self.configuration should return configuration' do
    expect(subject.configuration).to be_kind_of(Render::Component::Configuration)
  end
end
