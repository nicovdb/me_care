class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.request = request
    if @contact.deliver
      flash[:info] = "Votre message a bien été envoyé !"
      redirect_to message_sent_path
    else
      flash.now[:error] = "Votre message n'a pas pu être envoyé, veuillez réessayer ou écrire à bonjour@easyendo.fr"
      render :new
    end
  end

  def message_sent
  end

  private

  def skip_pundit?
    true
  end

  private
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :message, :nickname)
  end
end
