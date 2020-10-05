module Thredded
  class MessageboardsController < Thredded::ApplicationController
    def index
      if current_user.has_valid_subscription?
        @groups = Thredded::MessageboardGroupView.grouped(
        policy_scope(Thredded::Messageboard.all),
        user: thredded_current_user
        )
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end
end
