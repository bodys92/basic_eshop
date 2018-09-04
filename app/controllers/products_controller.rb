class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update,:destroy]
  before_action :admin?, only: [:new, :create, :edit, :update,:destroy]

    def index
        @products = Product.all.order(:created_at).paginate(page: params[:page])
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.create(accept_params)

        params[:product_categories][:category_id].each do |n|
        @category = @product.product_categories.build(category_id: n)
            unless @category.save
                flash[:danger] = "Unsuccesfull add"
                render 'new'
            end
        end

        if @product.save
            flash[:info] = "Succesfull add"
            redirect_to product_url(@product)
        else
            render 'new'
        end
    end

    def show
        @product = Product.find(params[:id])
        categories = ProductCategory.where(product_id: params[:id])
        @items = []
        categories.each do |i|
            @items << i.category_id
        end
        @cat = []
        @items.each do |i|
            @cat << Category.find(i)
        end
    end

    def update
    end

private 

    def accept_params
        params.require(:product).permit(:code, 
                                        :url,
                                        :title, 
                                        :short_description, 
                                        :description,
                                        :price,
                                        :old_price,
                                        :picture) 
    end
end
