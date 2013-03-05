class SubscribersController < ApplicationController
  def index
    @subscribers = Subscriber.not_added
    @count = @subscribers.count
  end

  def url_parser
    @params = params.slice :email, :first_name, :ip, :last_name, :lead_date, :url
    if Subscriber.create @params
      return head :ok
    else
      return head :bad_request
    end
  end
end
