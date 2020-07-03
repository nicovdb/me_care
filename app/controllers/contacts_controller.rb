class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:alert] = "Votre message a bien été envoyé"
      redirect_to new_contact_path
    else
      flash.now[:error] = "An error has occured, the message cannot be sent."
      render :new
    end
  end

  private

  def skip_pundit?
    true
  end
end
