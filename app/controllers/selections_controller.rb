class SelectionsController < ApplicationController
  def change_contact_person
    @contact_person = ContactPerson.where(target_client_id: params[:send_id])
    render json: @contact_person
  end

  def change_address
    @address = Address.where(target_client_id: params[:send_id])
    render json: @address
  end

  def change_target_client
    @address = TargetClient.where(client_id: params[:send_id])
    render json: @address
  end
end
