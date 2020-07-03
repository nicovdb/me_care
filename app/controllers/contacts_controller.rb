class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:error] = "Votre message a bien été envoyé"
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
