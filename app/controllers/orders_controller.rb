<<<<<<< HEAD
class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.build_customer
  end

  def index
    if user_signed_in?
      @orders = current_user.orders.includes(:order_items => :product)
    else
      @orders = [] # You might want to handle this case differently depending on your requirements
    end
  end
  
  
  
  def create
    ActiveRecord::Base.transaction do
      @order = Order.new(order_params)
      @order.user = current_user if user_signed_in? # Associate the order with the current user if logged in
      @order.status = "Pending"
      # process cart and calculate total before saving
      subtotal = process_cart
  
      # Get the province_id
      province_id = @order.customer.province_id
  
      @order.total, @order.gst, @order.pst, @order.hst, @order.subtotal = calculate_total(subtotal,
                                                                                          province_id)
      if @order.save
        session.delete(:cart)
        flash[:success] = "Order was successfully created."
        redirect_to review_order_path(@order)
      else
        flash.now[:error] = "Failed to create the order. Please check your entries."
        Rails.logger.debug @order.errors.full_messages
        Rails.logger.debug @order.customer.errors.full_messages if @order.customer
        render :new
      end
    end
  end
  
  def review
    @order = Order.includes(:customer, order_items: [:product]).find(params[:id])
  end
  

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      :total, :status, :gst, :pst, :hst, :subtotal,
      customer_attributes: %i[name email address province_id]
    )
  end

  def process_cart
    subtotal = 0
    cart = session[:cart]
    cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.build(product: product, quantity: quantity, price: product.price)
      subtotal += product.price * quantity
    end
    subtotal
  end

  def calculate_total(subtotal, province_id)
    # Find the tax rates for the customer's province
    tax_rates = TaxRate.find_by(province_id: province_id)

    if tax_rates
      gst = subtotal * (tax_rates.gst_rate / 100)
      pst = subtotal * (tax_rates.pst_rate / 100)
      hst = subtotal * (tax_rates.hst_rate / 100)
    else
      gst = pst = hst = 0
    end

    total = subtotal + gst + pst + hst
    [total, gst, pst, hst, subtotal]
  end
end



=======
# app/controllers/orders_controller.rb

class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    @order.customer = current_customer
    @order.total = calculate_total

    if @order.save
      session[:cart].each do |product_id, details|
        product = Product.find(product_id)
        @order.order_items.create!(
          product: product,
          quantity: details['quantity'],
          price: product.price_in_cart # Use the price_in_cart stored in the cart session
        )
      end

      session[:cart] = nil # Empty the cart after the order is placed

      # Calculate the taxes for the order
      if params[:order][:province_id].present?
        province = Province.find(params[:order][:province_id])
        tax_rates = province.tax_rates
        @order.hst = @order.total * tax_rates['hst']
        @order.gst = @order.total * tax_rates['gst']
        @order.pst = @order.total * tax_rates['pst']

        # Save the tax amounts to the order
        @order.save
      end

      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @customer_details = {
      name: @order.name,
      address: @order.address,
      email: @order.email,
      province: @order.province&.name
    }
  end

  def current_customer
    if session[:customer_id]
      @current_customer ||= Customer.find(session[:customer_id])
    else
      # Handle the case where there is no customer in the session.
      # Depending on your application, you might want to create a new customer,
      # show an error, redirect the user, etc.
      # For now, we'll just return nil.
      nil
    end
  end
  
  
    private
  
    def order_params
      params.require(:order).permit(:name, :address, :email, :province_id)
    end
  
    def calculate_total
      # Assuming 'total_price' in cents and an integer for better precision
      session[:cart].map { |product_id, details| details['price'] * details['quantity'] }.sum
    end
  
    def create_order_items!
      session[:cart].each do |product_id, details|
        @order.order_items.create!(
          product_id: product_id,
          price: details['price'],
          quantity: details['quantity']
        )
      end
    end
  end
  
>>>>>>> origin/master
