class SubscribersController < ApplicationController
  def url_parser
    @params = params.slice :email, :first_name, :ip, :last_name, :lead_date, :url
    Subscriber.create @params
  end

  def index
    @subscribers = Subscriber.all
  end
end
