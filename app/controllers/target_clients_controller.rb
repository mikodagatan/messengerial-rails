class TargetClientsController < ApplicationController
  def new
    @client = Client.find(params[:client_id])
    @target_client = @client.target_clients.build
    @address = @target_client.addresses.build
  end

  def create
    @client = Client.find(params[:client_id])
    @target_client = @client.target_clients.build(target_client_params)
    if @target_client.save
      flash[:success] = "Target Client created"
      redirect_to root_url
    else
      flash[:danger] = @target_client.errors.full_messages
      render action: :new
    end
  end

  def show
    @client = Client.find(params[:client_id])
    @target_client = TargetClient.find(params[:id])
    @addresses = @target_client.addresses.order(created_at: :asc)
    @contact_persons = @target_client.contact_persons.order(created_at: :asc)
  end

  private

  def target_client_params
    params.require(:client).permit(
      :id,
      :name,
      addresses_attributes: [
        :id,
        :first_line,
        :second_line,
        :city_town,
        :province,
        :country,
        :zipcode
      ]
    )
  end

end
