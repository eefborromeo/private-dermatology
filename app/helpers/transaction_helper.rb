module TransactionHelper
  def process_transaction(data_array)    
    result = ""

    data_array.each do |each|
      cart_record = current_user.cart_items.find(each[:cart_record])
      product_record = Product.find(each[:prod_record])

      new_transaction = current_user.transactions.create(
        prod_name: each[:name],
        prod_desc: each[:desc],
        prod_price: each[:price].to_i,
        prod_quantity: each[:quantity].to_i,
        prod_total: each[:total].to_i
      )

      if new_transaction.persisted?
        product_record.stocks -= each[:quantity].to_i
        product_record.save
        cart_record.destroy!
        result = true
      else
        result = false
      end
    end

    result
  end

  def display_cart_items_to_checkout(param_array)
    result = []
    items = []
    
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

      result << data      
    end

    result
  end
end
