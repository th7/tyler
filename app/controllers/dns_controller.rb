class DnsController < ApplicationController
  before_action :check_auth

  def show
    if entry = DnsEntry.where(url: params[:id]).first
      render json: entry.ip
    else
      render json: 'none found', status: 404
    end
  end
=begin
  curl -vv -u username:password -X GET -H "Accept: application/json" -H "Content-Type: application/json" -d '{
  "user": {
    "username": "username",
    "password": "password"
  }
}' http://localhost:3000/dns/a_new_url
=end
  def create
    if entry = DnsEntry.where(url: dns_entry_params[:url]).first
      entry.update_attributes(dns_entry_params)
      render json: entry
    elsif entry = DnsEntry.create(dns_entry_params)
      render json: entry
    else
      render json: 'failed', status: 400
    end
  end

  private

  def dns_entry_params
    params.require(:dns).permit(:url, :ip)
  end

=begin
  curl -vv -u username:password -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d '{
  "dns": {
    "url": "a_new_url",
    "ip": "127.0.0.2"
  },
  "user": {
    "username": "username",
    "password": "password"
  }
}' http://localhost:3000/dns
=end
end
