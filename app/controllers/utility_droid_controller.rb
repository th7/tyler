class UtilityDroidController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:get_sms, :send_sms, :register, :save_sms]
  before_action :check_auth

  def register
    current_user.registration_id = params[:user][:registration_id]

    if current_user.save
      render :nothing => true, :status => 200, :content_type => 'text/html'
    else
      render :status => :bad_request, :text => ''
    end
  end

  def send_sms
    reg_id = current_user.registration_id
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

  def get_sms
    render :json => SmsMessage.order('sent_at DESC').limit(params[:quantity]).offset(params[:offset])
  end

  def save_sms
    # params[:sms] = JSON.parse(params[:sms])
    sms = SmsMessage.new(sms_params)
    if sms.save
      render :nothing => true, :status => 200, :content_type => 'text/html'
    else
      render :status => :bad_request, :text => ''
    end
  end

  private

  def check_auth
    render :status => :bad_request, :text => '' unless current_user
  end

  def sms_params
    params.require(:sms).permit(:text, :from, :sent_at)
  end
end
