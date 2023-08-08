<<<<<<< HEAD
class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :add_common_breadcrumbs

  def index
    @products = Product.page(params[:page]).per(10)

    @products = @products.where(on_sale: true) if params[:on_sale]
    @products = @products.where("created_at >= ?", 3.days.ago) if params[:new]
    @products = @products.where("updated_at >= ?", 3.days.ago) if params[:recently_updated]

    if params[:search].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%",
                                  "%#{params[:search]}%")
    end

    if params[:category].present?
      @category = Category.find(params[:category])
      add_breadcrumb @category.name, category_path(@category)
      @products = @products.where(category_id: params[:category])
    end
  end

  def show
    if @product.category
      add_breadcrumb @product.category.name, category_path(@product.category)
    end
    add_breadcrumb @product.name, product_path(@product)
  end


  private

  def set_product
    @product = Product.find(params[:id])
  end

  def add_common_breadcrumbs
    add_breadcrumb "Home", root_path
    add_breadcrumb "Products", products_path
  end
end


=======
# app/controllers/products_controller.rb

class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(10)

    # Filter for "on_sale" products
    @products_on_sale = @products.where(on_sale: true)

    # Filter for "new" products (added within the past 3 days)
    @new_products = @products.where("created_at >= ?", 3.days.ago)

    # Filter for "recently updated" products (updated within the past 3 days)
    @recently_updated_products = @products.where("updated_at >= ?", 3.days.ago)
  # Search functionality
  if params[:search].present?
    @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
  end

  if params[:category].present?
    @products = @products.where(category_id: params[:category])
  end
end

  def show
    @product = Product.find(params[:id])
  end

  def on_sale
    @products = Product.where(on_sale: true).page(params[:page]).per(10)
    render 'index'
  end

  def new_products
    @products = Product.where('created_at >= ?', 3.days.ago).page(params[:page]).per(10)
    render 'index'
  end

  def recently_updated
    @products = Product.where('updated_at >= ?', 3.days.ago).page(params[:page]).per(10)
    render 'index'
  end

  def add_to_cart
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i
  
    # Check if the cart is already initialized in the session, if not, initialize it as an empty hash
    session[:cart] ||= {}
  
    # Add the product, price, and quantity to the cart
    session[:cart][product.id] ||= { quantity: 0, price: product.price }
    session[:cart][product.id][:quantity] += quantity
  
    redirect_to products_path, notice: "#{quantity} #{'item'.pluralize(quantity)} added to the cart."
  end
  def cart
    # Retrieve the products in the cart based on the session data
    @cart_products = session[:cart]&.keys
  
    # Use the @cart_products array to fetch the corresponding products from the database
    @products_in_cart = Product.where(id: @cart_products)
  
    # Set the price_in_cart and quantity_in_cart attributes for each product in the cart
    @products_in_cart.each do |product|
      product_in_cart = session[:cart][product.id]
      product.price_in_cart = product_in_cart&.dig(:price_in_cart) || product.price
      product.quantity_in_cart = product_in_cart&.dig(:quantity) || 0
    end
  end
  
  
  def update_cart
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    # Check if the cart is already initialized in the session, if not, initialize it as an empty hash
    session[:cart] ||= {}

    # Fetch the product
    product = Product.find(product_id)

    # Initialize the product in the cart with quantity and price if it doesn't exist
    session[:cart][product_id] ||= { quantity: 0, price_in_cart: product.price }

    # Update the quantity in the session data
    session[:cart][product_id][:quantity] = quantity

    respond_to do |format|
      format.html { redirect_to cart_products_path, notice: "Quantity updated successfully." }
      format.js
    end
  end
  
  
  
  
  

  def remove_item
    product_id = params[:product_id]
    session[:cart].delete(product_id) if session[:cart].include?(product_id)  # Replace with your condition when removal is successful
    if session[:cart].include?(product_id)
      head :unprocessable_entity
    else
      head :ok
    end
  end
  
end
>>>>>>> origin/master
