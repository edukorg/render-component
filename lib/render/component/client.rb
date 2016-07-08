require 'json'
require 'curb'

class Render::Component::Client

  def obtain_component(component, attributes)
    execute_request(component, attributes)
  end

  private

  def execute_request(component, attributes)

    url = "#{default_endpoint}/#{component}"

    response = Curl.post(url, apply_default_attributes(attributes)) do |curl|
      curl.connect_timeout = 3
    end

    code = response.status.to_i

    return response.body_str if code == 200

    raise StandardError.new, "Request Error. URL: #{url}, Response Status Code: #{code}"
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
