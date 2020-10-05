module Thredded
  module UserPermissions
    module Write
      module All
        extend ActiveSupport::Concern

        # @return [ActiveRecord::Relation<Thredded::Messageboard>] messageboards that the user can post in
        def thredded_can_write_messageboards
          if self.has_valid_subscription?
            Thredded::Messageboard.all
          else
            raise Pundit::NotAuthorizedError
          end
        end
      end
    end
  end
end
