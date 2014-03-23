Tyler::Application.routes.draw do
  root 'home#index'

  post 'utility_droid/register' => 'utility_droid#register'
  post 'sms/send' => 'utility_droid#send_sms'
  post 'sms/get' => 'utility_droid#get_sms'
  post 'sms/save' => 'utility_droid#save_sms'

  get 'pdf' => 'home#pdf'

  get 'dns' => 'dns#remote_ip'
  get 'dns/:id/check_ip' => 'dns#check_ip'
  get 'dns/:id/*route' => 'dns#redirect'
  post 'dns' => 'dns#upsert'
end
