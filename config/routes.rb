Tyler::Application.routes.draw do
  root 'home#index'

  post 'sms/get' => 'utility_droid#get_sms'

  get 'pdf' => 'home#pdf'
  post 'utility_droid/register' => 'utility_droid#register'
  post 'sms/send' => 'utility_droid#send_sms'
end
