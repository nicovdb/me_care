namespace :user do
  desc "check if trial is ending soon or just finished"
  task check_trial: :environment do
    subscriptions = Subscription.where(status: "trialing")
    subscriptions.each do |sub|
      if sub.end_date == Date.today + 2
        UserMailer.with(user: sub.user).trial_end_soon.deliver_now
      elsif sub.end_date < Date.today
        sub.update(status: "trial_ended")
      end
    end
  end

end
