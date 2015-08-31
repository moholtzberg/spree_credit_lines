module Spree
  class CreditLinesController < StoreController
    
    def process(*args)
      
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "#{params.inspect}"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
     
      
      order = current_order
      puts "***********************************"
      puts "Payment Required ==========#{order.payment_required?}"
      puts "Now Payment Required ==========#{order.payment_required?}"
      puts "Order Inspect ==========#{order.inspect}"
      puts "Order State ==========#{order.state}"
      puts "Order Next ==========#{order.next}"
      puts "Order State ==========#{order.state}"
      puts "***********************************"
      if params[:number].to_i > 10.to_i

        # puts "#{payment_method}"
        payment = order.payments.create!(
                  :amount => 0.0,
                  # :amount => order.total,
                  :payment_method_id => params[:payment_method_id]
        )
                payment.started_processing!
                puts payment.inspect
                payment.update_columns source_id: params[:payment_method_id], source_type: "Spree::PaymentMethod::CreditLine"
        
        #<Spree::Payment id: 10, amount: #<BigDecimal:7ff6e78ab6b0,'0.3637E2',18(36)>, order_id: 5, source_id: nil, source_type: nil, payment_method_id: nil, state: "checkout", response_code: nil, avs_response: nil, created_at: "2015-05-05 21:11:11", updated_at: "2015-05-05 21:11:11", number: "PVT6P75U", cvv_response_code: nil, cvv_response_message: nil>
        
        puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        # puts order.inspect
        # puts order.state
        # puts order.checkout_steps
        # order.next
        puts order.confirmation_required?
        puts order.state
        puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        
      else
        flash[:notice] = "Number is less than 10"
        redirect_to checkout_state_path(order.state) and return
      end
      
      if order.complete?
        # redirect_to checkout_state_path(order.state)
        redirect_to order_path(order, :token => order.guest_token)
      else
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{checkout_state_path(order.state)}"
        redirect_to checkout_state_path(order.state) and return
      end
    end
    
    def payment_method
      puts "#{@payment_method}"
      @payment_method
    end
    
  end 
end