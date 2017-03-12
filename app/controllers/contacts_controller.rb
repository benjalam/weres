class ContactsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
   @contact = Contact.new
    authorize @contact
  end

  def create
    @contact = Contact.new(contact_params)
    authorize @contact
    if @contact.save
     redirect_to(root_path)
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :first_name, :last_name, :message)
  end
end
