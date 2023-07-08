class PurchasesController < ApplicationController
  def index
    if params[:clientId]
      @purchases = Purchase.includes(:client).where(client_id: params[:clientId])
    else
      @purchases = Purchase.includes(:client).all #this is to allow queries to the Purchase table by Client Id (order_count)
    end

    render json: @purchases.to_json(include: { client: { only: [:id, :first_name, :last_name] } })
  end

  def show
    @purchase = Purchase.find(params[:id])
    render json: @purchase.to_json(include: { client: { only: [:id, :first_name, :last_name] } })
  end

  # Perform the search operation based on the search query. Join to include results from Clients table too
  def search
    search_query = params[:query].downcase

    purchases = Purchase.joins(:client).where('LOWER(product_name) LIKE :query OR LOWER(clients.first_name) LIKE :query OR LOWER(clients.last_name) LIKE :query', query: "%#{search_query}%")
    clients = purchases.map(&:client).uniq

    render json: { clients: clients, purchases: purchases.as_json(include: { client: { only: [:id, :first_name, :last_name] } }, only: [:id, :product_name, :price]) }
  end


  def create
    purchase = Purchase.new(purchase_params)

    if purchase.save
      render json: purchase, include: { client: { only: [:id, :first_name, :last_name] } }, status: :created
    else
      render json: purchase.errors, status: :unprocessable_entity
    end
  end

  def update
    purchase = Purchase.find(params[:id])
    if purchase.update(purchase_params)
      render json: purchase
    else
      render json: { error: 'Failed to update purchase' }, status: :unprocessable_entity
    end
  end


  def destroy
    purchase = Purchase.find(params[:id])
    purchase.destroy
    render json: { message: 'Order successfully deleted' }
  end

  #all methods are outside of the privatte block, otherwise they are not accessible
  private
  def purchase_params
    params.require(:purchase).permit(:product_name, :description, :price, :delivery_date, :client_id, :status, :payment_terms)
  end

end

