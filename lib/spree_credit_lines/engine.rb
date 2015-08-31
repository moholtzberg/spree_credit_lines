module Spree
  module CreditLine
    class Engine < Rails::Engine
      require 'spree/core'
      isolate_namespace Spree
      engine_name 'spree'
    
      initializer "spree.register.payment_methods", :after => "spree.register.payment_methods" do |app|
        app.config.spree.payment_methods << Spree::PaymentMethod::CreditLine
      end

      # config.to_prepare &method(:activate).to_proc
    end
  end
end
