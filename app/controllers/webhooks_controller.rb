class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!
  before_action :skip_authorization

  # def check_trial
  #   subscriptions = Subscription.where(status: "trialing")
  #   subscriptions.each do |sub|
  #     if sub.end_date == Date.today
  #       UserMailer.with(user: sub.user).trial_end_soon.deliver_now
  #     elsif sub.end_date < Date.today
  #       sub.update(status: "trial_ended")
  #     end
  #   end
  #   head 200, content_type: "text/html"
  # end
end
