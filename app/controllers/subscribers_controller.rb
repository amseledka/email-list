class SubscribersController < ApplicationController
  def index
    @subscribers = Subscriber.all
  end

  def url_parser
    @params = params.slice :email, :first_name, :ip, :last_name, :lead_date, :url
    Subscriber.create @params
  end
end
