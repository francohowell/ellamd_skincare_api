# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  # These Devise routes are only used internally; we skip all of the default controllers.
  mount_devise_token_auth_for "Identity",
    at: "default_auth",
    skip: [:passwords, :registrations, :sessions, :token_validations, :confirmations]

    # These are the authentication routes that we actually use in the app.
  devise_scope :identity do
    post "/identities/sign-in" => "authentication/sessions#create"
    get "/identities/current" => "authentication/sessions#current"
    post "/identities/forgot-password" => "authentication/passwords#create"
    post "/identities/reset-password" => "authentication/passwords#update"
  end

  mount StripeEvent::Engine, at: "/stripe-webhooks"

  # Our TwilioController catches all messages from Twilio and routes them appropriately.
  post "/twilio/webhook" => "twilio#webhook"

  namespace :my do
    get  "medical-profile-audits", to: "medical_profile_audits#index"
    post "regimens",               to: "regimens#update"
  end

  resources :customers, only: [:index, :show] do
  end

  get  "/products", to: "products#index"
  post "/products", to: "products#sync"

  get "/customers" => "customers#index"
  post "/customers/create" => "customers#create"
  post "/customers/:customer_id/create-visit" => "customers#create_visit"
  post "/customers/:customer_id/update" => "customers#update"
  post "/customers/:customer_id/update-phone" => "customers#update_phone"
  post "/customers/:customer_id/archive" => "customers#archive"
  post "/customers/:customer_id/photos" => "photos#index"
  post "/customers/:customer_id/photos/create" => "photos#create"
  get "/customers/:customer_id/messages" => "customer_messages#index"
  post "/customers/:customer_id/messages" => "customer_messages#create"

  resources :subscriptions, only: [] do
    get "discount-details", on: :member, to: "discount_details"
    get "payment-details", on: :member, to: "payment_details"

    post "add-payment-source", on: :member, to: 'add_payment_source'
    post "start", on: :member
    post "unpause", on: :member
    post "cancel", on: :member
    post "apply-code", on: :member, to: "apply_code"
  end

  post "/visits/:visit_id/delete" => "visits#delete"
  post "/visits/:visit_id/diagnosis" => "visits#diagnosis"
  post "/visits/:visit_id/regimen" => "visits#regimen"
  post "/visits/:visit_id/prescription" => "visits#prescription"
  post "/visits/:visit_id/photos" => "visits#photos"
  post "/visits/:visit_id/photo-conditions" => "visits#photo_conditions"

  get "/physicians" => "physicians#index"
  get "/pharmacists" => "pharmacists#index"
  get "/messages" => "messages#index"
  post "/messages" => "messages#create"
  post "/pharmacists/create" => "pharmacists#create"

  get "/conditions" => "conditions#index"
  get "/ingredients" => "ingredients#index"
  get "/formulations" => "formulations#index"

  # Prescription routes
  get "/prescriptions" => "prescriptions#index"
  get "/prescriptions/get-token/:prescription_token"  => "prescriptions#pdf_token",        as: :prescription_pdf_token
  get "/prescriptions/download/:prescription_token"   => "prescriptions#prescription_pdf", as: :prescription_pdf
  post "/prescriptions/:prescription_id/add-tracking" => "prescriptions#add_tracking"
end
