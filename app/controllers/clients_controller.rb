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
    @target_clients = @client.target_clients
  end

  private

  def client_params
    params.require(:client).permit(
      :id,
      :name
    )
  end

end
