require 'spec_helper'

describe Render::Component::Client do
  Render::Component.configuration.endpoint = 'http://eduk.com.br'

  subject { Render::Component::Client.new }

  describe '#obtain_component' do
    it 'should call execute_request' do
      expect(subject).to receive(:execute_request)
      subject.obtain_component('whatever-component', '{}')
    end
  end

  describe '#execute_request' do
    context 'when request get success' do
      it 'should return the response body' do
        obj = double('Net', code_type: Net::HTTPOK, body: '<body><h1>barz</h1></body>')
        allow(Net::HTTP).to receive(:start).and_return(obj)
        expect(subject.send(:execute_request, 'component', '{}')).to eql(obj.body)
      end
    end

    context 'when request get error' do
      it 'should raise error' do
        obj = double('Net', code_type: Net::HTTPFound)
        allow(Net::HTTP).to receive(:start).and_raise('Request errror')
        expect { subject.send(:execute_request, 'component', '{}') }.to raise_error('Request errror')
      end
    end
  end

  describe '#default_endpoint' do
    context "when haven't default endpoint" do
      it 'should raise error' do
        Render::Component.configuration.endpoint = nil
        expect { subject.send(:execute_request, 'component', '{}') }.to raise_error(Render::Component::Error, /you must add default endpoint/)
      end
    end
  end
end
