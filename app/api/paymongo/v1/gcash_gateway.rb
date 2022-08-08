module Paymongo
  module V1
    class GcashGateway
      include ApiErrors
      PUBLIC_KEY = ENV["PAYMONGO_PUBLIC_TEST"]
      PAYMENT_SUCCESS_REDIRECT = "http://localhost:3000/payments/gcash-payment/success"
      PAYMENT_FAILED_REDIRECT = "http://localhost:3000/payments/gcash-payment/failed"
      COMPANY_NAME = "Private Dermatology"
      
      def source_create(payment_amount, payment_category)
        url = URI("https://api.paymongo.com/v1/sources")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["Accept"] = 'application/json'
        request["Content-Type"] = 'application/json'
        request.basic_auth(PUBLIC_KEY, '')
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
        request.body = payload.to_json

        response = http.request(request)
        return JSON.parse response.read_body if response.is_a? Net::HTTPOK
        raise BadRequest
      end
    end
  end
end

