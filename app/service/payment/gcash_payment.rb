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
      amount = (gcash_source['data']['attributes']['amount'] / 100).to_s
    
      return {
        source_id: id,
        source_checkout_url: checkout_url,
        payment_category: description,
        amount: amount
      }
    end

    def self.process_payment(amount, source_id)
      gateway = Paymongo::V1::GcashGateway.new

      begin
        payment = gateway.payment_create(amount.to_i * 100, source_id)
      rescue ApiErrors::BadRequest
        raise StandardError
      end

      id = payment['data']['id']
      return id
    end
  end
end