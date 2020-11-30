module Thredded
  class MessageboardsController < Thredded::ApplicationController
    def index
      if current_user.has_valid_subscription? || current_user.admin?
        @groups = Thredded::MessageboardGroupView.grouped(
        policy_scope(Thredded::Messageboard.all),
        user: thredded_current_user
        )
      else
        raise Pundit::NotAuthorizedError
      end
    end

    def new
      if current_user.has_valid_subscription? || current_user.admin?
        @new_messageboard = Thredded::Messageboard.new
        authorize_creating @new_messageboard
      else
        raise Pundit::NotAuthorizedError
      end
    end

    def create
      if current_user.has_valid_subscription? || current_user.admin?
        @new_messageboard = Thredded::Messageboard.new(messageboard_params)
        authorize_creating @new_messageboard
        if Thredded::CreateMessageboard.new(@new_messageboard, thredded_current_user).run
          redirect_to root_path
        else
          render :new
        end
      else
        raise Pundit::NotAuthorizedError
      end
    end

    def edit
      if current_user.has_valid_subscription? || current_user.admin?
        @messageboard = Thredded::Messageboard.friendly_find!(params[:id])
        authorize @messageboard, :update?
      else
        raise Pundit::NotAuthorizedError
      end
    end

    def update
      if current_user.has_valid_subscription? || current_user.admin?
        @messageboard = Thredded::Messageboard.friendly_find!(params[:id])
        authorize @messageboard, :update?
        if @messageboard.update(messageboard_params)
          redirect_to messageboard_topics_path(@messageboard), notice: I18n.t('thredded.messageboard.updated_notice')
        else
          render :edit
        end
      else
        raise Pundit::NotAuthorizedError
      end
    end

    def destroy
      if current_user.has_valid_subscription? || current_user.admin?
        @messageboard = Thredded::Messageboard.friendly_find!(params[:id])
        authorize @messageboard, :destroy?
        @messageboard.destroy!
        redirect_to root_path, notice: t('thredded.messageboard.deleted_notice')
      else
        raise Pundit::NotAuthorizedError
      end
    end

    private

    def messageboard_params
      params
        .require(:messageboard)
        .permit(:name, :description, :messageboard_group_id, :locked)
    end

  end
end
