Spree::Core::Engine.routes.draw do
  get "checkout/payment/credit_line", to: "credit_lines#confirm", as: :credit_line_confirmation
  post "credit_line/notify", to: "credit_lines#notify"
  post "credit_line/process", to: "credit_lines#process", as: :credit_line_process
end
