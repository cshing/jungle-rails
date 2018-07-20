class ReviewsController < ApplicationController

  before_filter :authorize
  
  def create
    @product = Product.find(params[:product_id])
    @review = @product.review.create(review_params)

    if @review.save
      redirect_to @product, notice: 'review has been successfully created!'
    else
      redirect_to :back, notice: 'something went wrong'
    end
  end

  def destroy
    @delete = Review.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(
     :description, :rating
    ).merge(user_id:current_user.id)
  end

end
