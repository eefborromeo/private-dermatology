module Paymongo
  module V1
    class GcashGateway
      include ApiErrors
      PUBLIC_KEY = ENV["PAYMONGO_PUBLIC_TEST"]
      SECRET_KEY = ENV["PAYMONGO_SECRET_TEST"]
      PAYMENT_SUCCESS_REDIRECT = "https://private-dermatology.herokuapp.com/payments/gcash-payment/success"
      PAYMENT_FAILED_REDIRECT = "https://private-dermatology.herokuapp.com/payments/gcash-payment/failed"
      COMPANY_NAME = "Private Dermatology"

      def _http(url)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http
      end
      
      def _request(url, payload, api_key)
        request = Net::HTTP::Post.new(url)
        request["Accept"] = 'application/json'
        request["Content-Type"] = 'application/json'
        request.basic_auth(api_key, '')
        request.body = payload.to_json
        request
      end
      
      def source_create(payment_amount, payment_category)
        payload = {
          "data":{
            "attributes":{
              "amount": payment_amount,
              "redirect":{
                "success": PAYMENT_SUCCESS_REDIRECT,
                "failed": PAYMENT_FAILED_REDIRECT
              },
              "type":"gcash",
              "currency":"PHP",
              "description": payment_category,
              "statement_descriptor": COMPANY_NAME
            }
          }
        }
        url = URI("https://api.paymongo.com/v1/sources")
        http = _http(url)
        request = _request(url, payload, PUBLIC_KEY)
        response = http.request(request)
        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end

      def payment_create(payment_amount, source_id)
        payload = {
          "data": {
            "attributes": {
              "amount": payment_amount,
              "source": {
                "type": "source",
                "id": source_id
              },
              "currency": "PHP",
              "description": "Gcash Payment",
              "statement_descriptor": COMPANY_NAME
            }
          }
        }
        url = URI("https://api.paymongo.com/v1/payments")
        http = _http(url)
        request = _request(url, payload, SECRET_KEY)
        response = http.request(request)
        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end
    end
  end
end