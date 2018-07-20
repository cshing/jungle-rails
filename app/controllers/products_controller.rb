class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.where(product_id: @product.id)
    @review.each do |review|
     @user = User.where(id: review.user_id)
    end
  end

end
