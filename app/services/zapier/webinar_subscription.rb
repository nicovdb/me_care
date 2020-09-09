module Zapier
  class WebinarSubscription < Zapier::Base
    def call_operation
      HTTParty.post(ENV["ZAP_NEW_WEBINAR_SUBSCRIPTION"], body: params)
    end

    def params
      {
        webinar_name: "#{resource.webinar.start_at.strftime("%Y-%m-%d")} #{resource.webinar.title}",
        user_email: resource.user.email
      }
    end
  end
end
