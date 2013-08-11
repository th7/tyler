class HomeController < ApplicationController
  def index
  end

  def pdf
    send_file Rails.root.join('app', 'assets', 'Tyler-Hartland.pdf'), type: 'application/pdf'
  end
end
