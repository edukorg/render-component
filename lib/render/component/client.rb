require 'json'
require 'net/http'

class Render::Component::Client

  def obtain_component(component, attributes)
    execute_request(component, attributes)
  end

  private

  def execute_request(component, attributes)
    uri = URI("#{default_endpoint}/#{component}")

    response = Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new(uri.path)
      request.content_type = 'application/json'
      request.body = attributes

      http.request(request)
    end

    return response.body if response.code_type == Net::HTTPOK

    raise StandardError.new, "Request Error. Uri: #{uri}, Response Code Type: #{response.code_type}, Response Code: #{response.code}"
  end

  def default_endpoint
    endpoint = Render::Component.configuration.endpoint
    raise Render::Component::Error.new, error_message if endpoint.nil?
    endpoint
  end

  def error_message
    'To use `obtain_component` you must add default endpoint. e.g. Render::Component.configuration.endpoint='
  end
end
