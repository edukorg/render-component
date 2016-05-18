require 'spec_helper'

describe Render::Component::Helper do
  describe '#render_component' do
    context 'when request get success' do
      it 'should return the response body' do
        body = '<body><h1>barz</h1></body>'
        allow_any_instance_of(Render::Component::Client).to receive(:obtain_component).and_return(body)
        expect(subject.render_component(JSON.generate(component: :header))).to eql(body)
      end
    end
  end
end
