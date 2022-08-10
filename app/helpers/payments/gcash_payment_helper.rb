module Payments
  module GcashPaymentHelper
    def check_product_stock_availability_before_payment(items_array)
      result = true
      items_array.each do |each|
        product_record = Product.find(each["prod_record"])

        if product_record.stocks == 0
          result = false
        end
      end
      result
    end

    def check_slot_availability_before_payment(appointment)
      result = true
      appt = Appointment.find(appointment)

      if Slot.find(appt.slot_id).availability == false
        result = false
      end
      result
    end
  end
end