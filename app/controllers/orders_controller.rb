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
  