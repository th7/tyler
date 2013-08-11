Tyler::Application.routes.draw do
  root 'home#index'
  get 'pdf' => 'home#pdf'
  post 'utility_droid/register' => 'utility_droid#register'
  post 'utility_droid/send' => 'utility_droid#send_sms'
end
