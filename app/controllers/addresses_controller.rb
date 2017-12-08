class AddressesController < ApplicationController
  def new
    @client = Client.find(params[:client_id])
    @address = Address.new
  end

  def create
    @client = Client.find(params[:client_id])
    @address = Address.new(address_params)
    @address.client_id = @client.id
    if @address.save
      flash.now[:success] = 'Address Saved'
      redirect_to client_url(@client)
    else
      flash.now[:danger] = 'Address not saved'
      render action: :new
    end
  end

  private

  def address_params
    params.require(:address).permit(
      :id,
      :first_line,
      :second_line,
      :city_town,
      :province,
      :country,
      :zipcode
    )
  end
end
