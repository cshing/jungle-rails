class Review < ActiveRecord::Base
    belongs_to :product

    validates :product_id, :user_id, :description, :rating, presence: true
    validates :rating, inclusion: 1..5
    
end
