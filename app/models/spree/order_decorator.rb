Spree::Order.class_eval do
  
  checkout_flow do
    puts "------------------------------------------------------------------do something order checkout_flow"
    go_to_state :address
    go_to_state :delivery
    go_to_state :payment, if: ->(order) {
      order.update_totals
      # order.payment_required?
    }
    go_to_state :confirm
    go_to_state :complete
  end

  # If true, causes the payment step to happen during the checkout process
  def payment_required?
    return false
  end

  # If true, causes the confirmation step to happen during the checkout process
  def confirmation_required?
    return true
  end

end