class ClientsController < ApplicationController
  def new
    @client = Client.new
    @address = @client.addresses.build
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash.now[:success] = "Client created"
      redirect_to root_url
    else
      flash.now[:danger] = @client.errors.full_messages
      render action: :new
    end
  end

  def show
    @client = Client.find(params[:id])
    @addresses = @client.addresses.order(created_at: :asc)
    @contact_persons = @client.contact_persons
  end

  private

  def client_params
    params.require(:client).permit(
      :id,
      :name,
      addresses_attributes: [
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
