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
      request.body = apply_default_attributes(attributes)

      http.request(request)
    end

    return response.body if response.code_type == Net::HTTPOK

    raise StandardError.new, "Request Error. Uri: #{uri}, Response Code Type: #{response.code_type}, Response Code: #{response.code}"
  end

  def apply_default_attributes(attributes)
    body = JSON.parse(attributes)
    body['base_path'] = default_base_path
    JSON.generate(body)
  end

  def default_base_path
    base_path = Render::Component.configuration.base_path
    raise Render::Component::Error.new, configuration_error_message(__method__, 'base_path') if base_path.nil?
    base_path
  end

  def default_endpoint
    endpoint = Render::Component.configuration.endpoint
    raise Render::Component::Error.new, configuration_error_message(__method__, 'endpoint') if endpoint.nil?
    endpoint
  end

  def configuration_error_message(method, attribute)
    "To use `#{method}` you must add default #{attribute}. e.g. Render::Component.configuration.#{attribute}="
  end
end
