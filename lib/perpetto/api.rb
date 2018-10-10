require 'bundler/setup'
require 'httparty'
require 'json'

module Perpetto
  class API

    def initialize(account_id, secret)
      @account_id = account_id
      @secret = secret
    end

    def get_shop_info
      get('')
    end

    def get_containers
      get('info/containers')
    end

    def get_campaigns
      get('info/campaigns')
    end

    def cart_paid(cart_id)
      post('backend_track/cart_paid', {cart_id: cart_id})
    end

    def order_voided(cart_id)
      post('backend_track/order_voided', {cart_id: cart_id})
    end

    def item_updated(item_id, item_hash)
      post('backend_track/items_updated', {items: {item_id => item_hash}})
    end

    def profile_info(email)
      get("info/profile", {email: email})
    end

    def delete_store_data
      post('backend_action/delete_domain')
    end

    def delete_profile_data(email)
      post('backend_action/delete_profile', {email: email})
    end

    private
    def get(path, params = {})
      response = HTTParty.get(api_url(path, params))
      decode_and_check_response(response)
    end

    def post(path, body = {})
      response = HTTParty.post(api_url(path), body: body.to_json, headers: {'Content-Type' => 'application/json' })
      decode_and_check_response(response)
    end

    def decode_and_check_response(response)
      response_hash = JSON.parse(response.body)
      puts "Perpetto response: #{response_hash}"
      raise "Perpetto API returned error: #{response_hash['error']}" if response_hash['status'] == 'error'
      response_hash['data']
    end

    private
    def api_url(path, params = {})
      uri = URI("https://#{@account_id}.api.perpetto.com/v3/#{path}")
      uri.query = URI.encode_www_form(params.merge(secret: @secret))
      uri.to_s
    end
  end
end
