require 'uri'
require 'json'
require 'net/http'
require "addressable/uri"
require 'open-uri'

class Skipio
  API_SERVER = 'https://stage.skipio.com'

  def initialize(options)
    @token = options[:token]
    @params = options[:params]
  end

  def contact_list
    page_parameters = @params || { page: 1, per: 10 }
    url = "#{API_SERVER}/api/v2/contacts?token=#{@token}&#{request_parameters(page_parameters)}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def send_message
    uri = URI.parse("#{API_SERVER}/api/v2/messages?token=#{@token}")
    json_data = build_json_message_data
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/json'})
    request.set_form_data(JSON.parse(json_data.to_json))
    response = http.request(request)
    JSON.parse(response.body)
  end

  def request_parameters(request_parameters)
    uri = Addressable::URI.new
    uri.query_values = request_parameters
    uri.query
  end
  
  def by_url(action, url)
    uri = URI.parse("#{API_SERVER}/api#{action}?token=#{@token}")
    if action == :get
      # do get request
    end
  end

  def build_json_message_data
    {
      "recipients": [
        @params[:recipients]
      ],
      "message": {
        "body": @params[:message]
      }
    }
  end
end
