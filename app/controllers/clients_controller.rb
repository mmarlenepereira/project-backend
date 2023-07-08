class ClientsController < ApplicationController
  def index
    clients = Client.includes(:purchases)
    clients_with_order_count = clients.map do |client|
      {
        id: client.id,
        first_name: client.first_name,
        last_name: client.last_name,
        phone_number: client.phone_number,
        email: client.email,
        address: client.address,
        order_count: client.order_count # Use the pre-calculated order_count from the model
      }
    end

    render json: { clients: clients_with_order_count }
  end

  #Search
  def search
    query = params[:query].downcase

    # Search for clients matching the search query
    clients = Client.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?", "%#{query}%", "%#{query}%")

    clients_with_order_count = clients.map do |client|
      {
        id: client.id,
        first_name: client.first_name,
        last_name: client.last_name,
        phone_number: client.phone_number,
        email: client.email,
        address: client.address,
        order_count: client.order_count
      }
    end

    # Search for purchases matching the search query
    purchase_results = Purchase.joins(:client).where('LOWER(product_name) LIKE :query', query: "%#{query}%")

    render json: { clients: clients_with_order_count, purchases: purchase_results }
  end


  def show
    client = Client.find(params[:id])
    order_count = client.order_count

    render json: {
      id: client.id,
      first_name: client.first_name,
      last_name: client.last_name,
      phone_number: client.phone_number,
      email: client.email,
      address: client.address,
      order_count: order_count
    }
  end

  def create
    client = Client.new(client_params)

    if client.save
      render json: { message: 'New client successfully created', client: client }, status: :created
    else
      render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    client = Client.find(params[:id])

    if client.update(client_params)
      render json: { message: 'Client successfully updated', client: client }
    else
      render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    client = Client.find(params[:id])
    client.destroy
    head :no_content
    #render json: { message: 'Client successfully deleted' } # this was causing a DoubleRenderError and preventing the successful deletion
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :phone_number, :email, :address)
  end
end



