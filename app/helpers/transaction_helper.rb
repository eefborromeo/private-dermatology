module TransactionHelper
  def display_cart_items_to_checkout(param_array)
    result = []
    items = []
    subtotal = []
    
    param_array.each do |param|
      items << current_user.cart_items.find(param)
    end

    items.each do |item|
      item_quantity = item.quantity
      product_record = Product.find(item.product_id)

      data = {
        cart_record: item.id,
        prod_record: product_record.id,
        name: product_record.product_name,
        desc: product_record.product_desc,
        price: product_record.price,
        quantity: item_quantity,
        total: (product_record.price * item_quantity)
      }

      subtotal << product_record.price * item_quantity
      result << data      
    end
    
    [result, subtotal.reduce(:+)]
    #a shortcut for subtotal.reduce(0) { |amount, total| amount + total }
  end

  def process_product_transaction
    data_array = session[:transaction_data]
    data_array.each do |each|
      cart_record = current_user.cart_items.find(each["cart_record"])
      product_record = Product.find(each["prod_record"])

      new_transaction = current_user.product_transactions.create(
        transaction_id: session[:gcash_source_id],
        transaction_amount: session[:transaction_amount],
        prod_name: each["name"],
        prod_desc: each["desc"],
        prod_price: each["price"].to_i,
        prod_quantity: each["quantity"].to_i,
        prod_total: each["total"].to_i
      )

      if new_transaction.persisted?
        product_record.stocks -= each["quantity"].to_i
        product_record.save
        cart_record.destroy!
        process_webhook_event(new_transaction)
      else
        raise StandardError
      end
    end
    clear_session_variables
  end

  def process_appointment_transaction
    appointment_id = session[:transaction_data]
    appt = Appointment.find(appointment_id)
    slot = Slot.find(appt.slot_id)
    date = slot.date
    time = slot.time

    new_transaction = current_user.appointment_transactions.create(
      transaction_id: session[:gcash_source_id],
      transaction_amount: session[:transaction_amount],
      appt_date: date,
      appt_time: time,
      appt_reason: appt.reason,
      appt_note: appt.note,
      appt_interaction: appt.interaction,
      appt_status: "paid"
    )

    if new_transaction.persisted?
      appt.destroy!
      slot.availability = false
      slot.save
      initialize_google_event(new_transaction)
      process_webhook_event(new_transaction)
      clear_session_variables
    else
      raise StandardError
    end
  end

  private

  def initialize_google_event(appointment_transaction)
    #this is the start of the google calendar event creation
    event_client = GoogleApi::GoogleCalendar::CalendarEvent.new
    event_client.create_google_event(appointment_transaction, current_user)
  end

  def process_webhook_event(transaction)
    # this will be called after the creation of the transaction record to simulate the real world asynchronous event from paymongo
    numeric = []
    for a in 1..5 do
      numeric << rand(0..9)
    end
    transaction.transaction_id = "pay-T_#{numeric.join("")}"
    transaction.save
  end

  def clear_session_variables
    session.delete(:gcash_source_id)
    session.delete(:payment_category)
    session.delete(:transaction_amount)
    session.delete(:transaction_data)
  end
end
