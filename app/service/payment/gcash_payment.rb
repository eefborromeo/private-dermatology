module Payment
  class GcashPayment    
    def self.initialize_source(amount, payment_category)
      gateway = Paymongo::V1::GcashGateway.new

      begin
        gcash_source = gateway.source_create(amount.to_i * 100, payment_category)
      rescue ApiErrors::BadRequest
        raise StandardError
      end

      id = gcash_source['data']['id']
      description = gcash_source['data']['attributes']['description']
      checkout_url = gcash_source['data']['attributes']['redirect']['checkout_url']
    
      return {
        transaction_id: id,
        source_checkout_url: checkout_url,
        payment_category: description
      }
    end

    
  end
end