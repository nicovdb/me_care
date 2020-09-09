module Zapier
  class WebinarCreated < Zapier::Base
    def call_operation
      HTTParty.post(ENV["ZAP_NEW_WEBINAR"], body: params)
    end

    def params
      {
        user_email: resource.email,
        user_first_name: resource.first_name,
        user_last_name: resource.last_name
      }
    end
  end
end
