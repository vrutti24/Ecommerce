class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts
  has_one :current_cart, -> { where status: "in_cart" }, class_name: "Cart"
end
