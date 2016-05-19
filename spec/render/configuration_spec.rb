require 'spec_helper'

describe Render::Component::Configuration do
  subject { Render::Component::Configuration.new }

  it { expect(subject.respond_to?(:endpoint)).to be_truthy }
  it { expect(subject.respond_to?(:endpoint=)).to be_truthy }
  it { expect(subject.respond_to?(:base_path)).to be_truthy }
  it { expect(subject.respond_to?(:base_path=)).to be_truthy }
end
