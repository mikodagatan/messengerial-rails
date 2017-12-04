class ContactPersonsController < ApplicationController
  def new
    @client = Client.find(params[:client_id])
    @contact_person = ContactPerson.new
  end

  def create
    @client = Client.find(params[:client_id])
    @contact_person = ContactPerson.new(contact_person_params)
    @contact_person.client_id = @client.id
    if @contact_person.save
      flash[:success] = "Contact_person saved"
      redirect_to root_url
    else
      flash[:danger] = "submission not saved"
      render action: :new
    end
  end

  def show
    @contact_person = Client.find(params[:id])
  end

  private

  def contact_person_params
    params.require(:contact_person).permit(
      :id,
      :first_name,
      :last_name,
      :contact_number
    )
  end
end
