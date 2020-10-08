class StripeTrialWillEndService
  def call(event)
    user = User.find_by(stripe_id: event.data.object.customer)
    trial_end = event.data.object.trial_end
    StripeMailer.with(user: user, trial_end: trial_end).trial_will_end.deliver_now
  end
end
