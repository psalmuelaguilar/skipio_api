require 'uri'
require 'json'
require 'net/http'
require "addressable/uri"
require 'open-uri'

class Skipio
  def initialize(options)
    @token = options[:token]
    @api_server = options[:api_server] || :dev
  end

  # params = { page: 1, per: 10 }
  def contact_list(params = nil)
    page_parameters = params || { page: 1, per: 10 }
    url = 'v2/contacts'
    response = process_by_url(url, :get, page_parameters)
    JSON.parse(response)
  end

  # contact_id = Contact#id
  def find_contact(contact_id)
    url = "/v2/contacts/#{contact_id}"
    response = process_by_url(url, :get)
    JSON.parse(response)
  end

  # params = { recipients: 'Comma Separated User UUID', message: 'body message' }
  def send_message(params = {})
    url = 'v2/messages'
    json_data = build_json_message_data(params)
    options = { json: json_data }
    response = process_by_url(url, :post, options)
    JSON.parse(response.body)
  end

  def request_parameters(request_parameters)
    uri = Addressable::URI.new
    uri.query_values = request_parameters
    uri.query
  end

  # action = :get / :post / :put
  # url = 'v1/contacts'
  # options = { params: { Hash: parameters }, json: { Hash: json } }
  def process_by_url(url, action, options = {})
    uri = URI.parse("#{api_server}/api/#{url}?token=#{@token}&#{options[:params]}")
    if action == :get
      response = Net::HTTP.get(uri)
    elsif action == :post
      json_data = options[:json].to_json
      response = create_by_url(uri, json_data)
    end

    response
  end

  def api_server
    if @api_server == :prod
      'https://app.skipio.com'
    elsif :dev
      'https://stage.skipio.com'
    end
  end

  private

  def create_by_url(uri, json_data)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/json'})
    request.set_form_data(JSON.parse(json_data))
    http.request(request)
  end

  def build_json_message_data(params)
    {
      "recipients": [
        params[:recipients]
      ],
      "message": {
        "body": params[:message]
      }
    }
  end
end
