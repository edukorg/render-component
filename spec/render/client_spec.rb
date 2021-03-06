require 'spec_helper'

def url(component)
  "#{subject.send(:default_endpoint)}/#{component}"
end

describe Render::Component::Client do

  subject { Render::Component::Client.new }

  before(:each) do
    Render::Component.configuration.endpoint = 'http://render.component.eduk.com.br'
    Render::Component.configuration.base_path = 'http://eduk.com.br'
  end

  describe '#obtain_component' do
    it 'should call execute_request' do
      expect(subject).to receive(:execute_request)
      subject.obtain_component('whatever-component', '{}')
    end
  end

  describe '#execute_request' do
    context 'when request get success' do
      let(:body_response) { '<body><h1>barz</h1></body>' }
      it 'should return the response body' do
        stub_request(:get, url('component'))
          .with(headers: {"X-Content": '{"base_path":"http://eduk.com.br"}'})
          .to_return(body: body_response)

        expect(subject.send(:execute_request, 'component', '{}')).to eql(body_response)
      end

      it 'should return the response body when attribute is a Hash' do
        stub_request(:get, url('component'))
          .with(headers: {"X-Content": '{"base_path":"http://eduk.com.br"}'})
          .to_return(body: body_response)

        expect(subject.send(:execute_request, 'component', {})).to eql(body_response)
      end
    end

    context 'when request get error' do
      it 'should raise error' do
        stub_request(:get, url('component'))
          .with(headers: {"X-Content": '{"base_path":"http://eduk.com.br"}'})
          .to_return(status: 404)
        expect { subject.send(:execute_request, 'component', '{}') }.to raise_error(StandardError, /Request Error. URL:.*?, Response Status Code: 404/)
      end
    end
  end

  describe '#default_endpoint' do
    context "when haven't default endpoint" do
      it 'should raise error' do
        Render::Component.configuration.endpoint = nil
        expect { subject.send(:default_endpoint) }.to raise_error(Render::Component::Error, /you must add default endpoint/)
      end

      context "when have default endpoint" do
        it 'should return endpoint' do
          expect(subject.send(:default_endpoint)).to_not be_nil
        end
      end
    end
  end

  describe '#default_base_path' do
    context "when haven't default base path" do
      it 'should raise error' do
        Render::Component.configuration.base_path = nil
        expect { subject.send(:default_base_path) }.to raise_error(Render::Component::Error, /you must add default base_path/)
      end
    end

    context "when have default base path" do
      it 'should return base path' do
        expect(subject.send(:default_base_path)).to_not be_nil
      end
    end
  end

  describe '#apply_default_attributes' do
    it 'should append base path' do
      expect(subject.send(:apply_default_attributes, '{"attr": "bar"}')).to eql("{\"attr\":\"bar\",\"base_path\":\"#{Render::Component.configuration.base_path}\"}")
    end
  end
end
