class UtilityDroidController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:send_sms, :register]
  def register
    user = User.find_by_username(params[:user][:username])
    return 500 unless user.password == params[:user][:password]
    if user
      user.registration_id = params[:user][:registration_id]
    else
      user = User.new(params[:user])
    end

    if user.save
      render :nothing => true, :status => 200, :content_type => 'text/html'
    else
      return 500
    end
  end

  def send_sms
    user = User.find_by_username(params[:user][:username])
    return 500 unless user.password == params[:user][:password]
    reg_id = user.registration_id
    server = 'https://android.googleapis.com'
    path = '/gcm/send'
    full_url = server + path

    header = {
      'Authorization' => params['Authorization'],
      'Content-Type' => 'application/json',
      'accept' => 'json'
    }

    data = JSON.parse(params[:data])

    new_params = {
      'data' => data,
      'registration_ids' => [reg_id]
    }

    resp = RestClient.post(full_url, new_params.to_json, header)
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
