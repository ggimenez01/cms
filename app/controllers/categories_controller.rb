# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
<<<<<<< HEAD
  before_action :set_category, only: %i[show otc prescription branded generic]
  before_action :add_common_breadcrumbs

  def index
    @products = Product.page(params[:page]).per(10)
  end

  def show
    add_breadcrumb @category.name, category_path(@category)
    @products = @category.products.page(params[:page]).per(10)
  end

  def otc
    otc_category("OTC")
  end

  def prescription
    otc_category("Prescription")
  end

  def branded
    otc_category("Branded")
  end

  def generic
    otc_category("Generic")
  end

  private

  def set_category
    @category = Category.find_by(name: params[:id])
  end

  def otc_category(name)
    @category = Category.find_or_create_by(name: name)
    add_breadcrumb @category.name, category_path(@category)
    @products = @category.products.page(params[:page]).per(10)
    render "show"
  end

  def add_common_breadcrumbs
    add_breadcrumb "Home", root_path
    add_breadcrumb "Categories", categories_path
  end
end
=======
    before_action :set_category, only: [:show, :otc, :prescription, :branded, :generic]
  
    def index
        @products = Product.page(params[:page]).per(10)
      end
    
      def show
        @products = @category.products.page(params[:page]).per(10)
      end
    
      def otc
        @category = Category.find_or_create_by(name: 'OTC')
        @products = @category.products.page(params[:page]).per(10)
        render 'show'
      end
      
    
      def prescription
        @category = Category.find_or_create_by(name: 'Prescription')
        @products = @category.products.page(params[:page]).per(10)
        render 'show'
      end
      
    
      def branded
        @category = Category.find_or_create_by(name: 'Branded')
        @products = @category.products.page(params[:page]).per(10)
        render 'show'
      end
    
      def generic
        @category = Category.find_or_create_by(name: 'Generic')
        @products = @category.products.page(params[:page]).per(10)
        render 'show'
      end
    
      private
    
      def set_category
        @category = Category.find_by(name: params[:id])
      end
    end
>>>>>>> origin/master
