module Spree
  Shipment.class_eval do
    puts "WE ARE HERE ____________________+++++++++++"
    def determine_state(order)
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> We Here Nigga"
      return 'canceled' if order.canceled?
      return 'pending' unless order.can_ship?
      return 'pending' if inventory_units.any? &:backordered?
      return 'shipped' if state == 'shipped'
      (order.paid? || Spree::Payment.find_by(:order_id => order.id, :source_type => "Spree::PaymentMethod::CreditLine")) || Spree::Config[:auto_capture_on_dispatch] ? 'ready' : 'pending'
    end
    
  end
end