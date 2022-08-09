module Admin
  module TransactionHelper
    def display_product_transactions
      result = []

      ProductTransaction.all.each do |pt|
        user = User.find(pt.user_id)
        puts "Hello"
        puts "Hello"
        puts "Hello"
        puts "Hello"
        puts user

        data = {
          full_name: user.full_name,
          email: user.email,
          name: pt.prod_name,
          quantity: pt.prod_quantity,
          total: pt.prod_total
        }

        result << data
      end

      result
    end

    def display_appointment_transactions
      result = []

      AppointmentTransaction.all.each do |at|
        user = User.find(at.user_id)

        data = {
          full_name: user.full_name,
          email: user.email,
          date: at.appt_date,
          time: at.appt_time,
          reason: at.appt_reason,
          interaction: at.appt_interaction
        }

        result << data
      end

      result
    end
  end
end