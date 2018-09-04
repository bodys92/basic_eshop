class Product < ApplicationRecord
    validates :code, presence:true, length: {maximum: 255}
    validates :url, presence:true, length: {maximum: 255}
    validates :title, presence:true, length: {maximum: 255}
    validates :short_description, presence:true, length: {maximum: 50}
    validates :description, presence:true, length: {maximum: 255}
    validates :price, presence:true, numericality: { greater_than: 0,
                                                    only_integer: false }

    has_many :product_categories
                                               
end
